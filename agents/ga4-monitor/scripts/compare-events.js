// n8n Code node: Compare GA4 events against event spec
// Detects gaps, unexpected events, and anomalies.

// ── 1. Pull inputs ────────────────────────────────────────────────────────────
const ga4Raw     = $('GA4 Fetch').first().json;
const specRaw    = $('Read Event Spec').first().json.data;
const prevRaw    = (() => {
  try { return $('Read Previous Counts').first().json.data; } catch { return null; }
})();
const autoEventsRaw = (() => {
  try { return $('Read Auto Events').first().json.data; } catch { return null; }
})();
const clientConfig = (() => {
  try { return $('Read Config').first().json; } catch { return {}; }
})();

// ── 2. Parse event spec ───────────────────────────────────────────────────────
const spec = typeof specRaw === 'string' ? JSON.parse(specRaw) : specRaw;

// ── 3. Parse previous counts ────────────────────────────────────────────────
// Supports two shapes:
//   Legacy:    { event_name: count } or { event_counts: { ... } }
//              → single prior period; only enables binary anomaly detection
//   Multi-day: { event_counts: {...}, history: [{date: "YYYY-MM-DD", counts: {event: n}}, ...] }
//              → enables rolling z-score and multi-baseline detection
let prevCounts = {};
let prevHistory = [];
if (prevRaw) {
  try {
    const parsed = typeof prevRaw === 'string' ? JSON.parse(prevRaw) : prevRaw;
    prevCounts  = parsed.event_counts ?? parsed;
    prevHistory = Array.isArray(parsed.history) ? parsed.history : [];
  } catch { /* ignore malformed */ }
}

// ── 4. Auto-collected event exclusion list ──────────────────────────────────
// Loaded from the optional "Read Auto Events" node (data/ga4-auto-events.json).
// Falls back to an embedded default if the node isn't wired in. The default
// must stay in sync with data/ga4-auto-events.json — this is the canonical
// fallback for deployments that don't yet plumb the data file through n8n.
const DEFAULT_AUTO = {
  automatic: [
    'first_visit', 'session_start', 'user_engagement', 'page_view',
    'first_open', 'screen_view', 'app_remove', 'app_update', 'os_update',
    'in_app_purchase',
  ],
  enhanced_measurement_web: [
    'scroll', 'click', 'view_search_results',
    'video_start', 'video_progress', 'video_complete',
    'file_download', 'form_start', 'form_submit',
  ],
  enhanced_measurement_mobile: [
    'notification_foreground', 'notification_dismiss',
    'notification_open', 'notification_receive', 'notification_send',
  ],
};

const autoEventsData = (() => {
  if (!autoEventsRaw) return DEFAULT_AUTO;
  try {
    const parsed = typeof autoEventsRaw === 'string' ? JSON.parse(autoEventsRaw) : autoEventsRaw;
    return parsed;
  } catch { return DEFAULT_AUTO; }
})();

const GA4_AUTO = new Set([
  ...(autoEventsData.automatic ?? []),
  ...(autoEventsData.enhanced_measurement_web ?? []),
  ...(autoEventsData.enhanced_measurement_mobile ?? []),
]);

// ── 5. Parse GA4 rows → { name, count, users } ───────────────────────────────
const ga4Events = {};

if (ga4Raw && Array.isArray(ga4Raw.rows)) {
  const dimHeaders    = (ga4Raw.dimensionHeaders || []).map(h => h.name);
  const metricHeaders = (ga4Raw.metricHeaders   || []).map(h => h.name);

  const eventNameIdx  = dimHeaders.findIndex(n => n === 'eventName');
  const eventCountIdx = metricHeaders.findIndex(n => n === 'eventCount');
  const totalUsersIdx = metricHeaders.findIndex(n => n === 'totalUsers');

  for (const row of ga4Raw.rows) {
    const dimVals    = row.dimensionValues || [];
    const metricVals = row.metricValues   || [];

    const name  = eventNameIdx  >= 0 ? (dimVals[eventNameIdx]?.value   ?? '') : '';
    const count = eventCountIdx >= 0 ? parseInt(metricVals[eventCountIdx]?.value ?? '0', 10) : 0;
    const users = totalUsersIdx >= 0 ? parseInt(metricVals[totalUsersIdx]?.value ?? '0', 10) : 0;

    if (name) {
      ga4Events[name] = { count, users };
    }
  }
}

// ── 6. Build spec event map ───────────────────────────────────────────────────
const specEventMap = {};

for (const group of (spec.event_groups || [])) {
  for (const ev of (group.events || [])) {
    specEventMap[ev.name] = {
      group_name : group.group_name ?? null,
      phase      : group.phase      ?? null,
      priority   : ev.priority      ?? null,
      replaces   : ev.replaces      ?? null,
      status     : ev.status        ?? null,
    };
  }
}

const specNames = new Set(Object.keys(specEventMap));
const ga4Names  = new Set(Object.keys(ga4Events));

// ── 7. Missing events ────────────────────────────────────────────────────────
const missing_events = [];
for (const name of specNames) {
  if (!ga4Names.has(name)) {
    const meta = specEventMap[name];
    missing_events.push({
      name,
      group    : meta.group_name,
      phase    : meta.phase,
      priority : meta.priority,
      replaces : meta.replaces,
      status   : meta.status,
    });
  }
}

const PRIORITY_ORDER = { critical: 0, high: 1, medium: 2, low: 3 };
missing_events.sort((a, b) => {
  const pa = PRIORITY_ORDER[a.priority] ?? 99;
  const pb = PRIORITY_ORDER[b.priority] ?? 99;
  if (pa !== pb) return pa - pb;
  if (a.phase !== b.phase) return (a.phase ?? 99) - (b.phase ?? 99);
  return a.name.localeCompare(b.name);
});

// ── 8. Unexpected events ──────────────────────────────────────────────────────
const unexpected_events = [];
for (const name of ga4Names) {
  if (!specNames.has(name) && !GA4_AUTO.has(name)) {
    unexpected_events.push({
      name,
      count : ga4Events[name].count,
      users : ga4Events[name].users,
    });
  }
}
unexpected_events.sort((a, b) => b.count - a.count);

// ── 9. Anomaly detection ─────────────────────────────────────────────────────
// Two methods, selected via clientConfig.anomaly_detection.method:
//   "binary"         — legacy: previous count >100, current === 0
//   "rolling_zscore" — multi-baseline (rolling 7d mean + same-day-last-week
//                      + same-day-4-weeks-ago); requires prevHistory
//   "auto" (default) — uses rolling_zscore if prevHistory has enough data,
//                      otherwise falls back to binary
const anomalyConfig = clientConfig?.anomaly_detection ?? {};
const anomalyMethod = anomalyConfig.method ?? 'auto';
const minHistoryDays = anomalyConfig.min_history_days ?? 14;
const zThreshold = anomalyConfig.z_threshold ?? 3.0;
const dropFloorPct = anomalyConfig.drop_floor_pct ?? 25;

let anomalies = [];
let anomaly_detection_method = 'binary';
let anomaly_detection_skipped_reason = null;

const hasEnoughHistory = prevHistory.length >= minHistoryDays;

const useRollingZScore =
  anomalyMethod === 'rolling_zscore' ||
  (anomalyMethod === 'auto' && hasEnoughHistory);

if (anomalyMethod === 'rolling_zscore' && !hasEnoughHistory) {
  anomaly_detection_skipped_reason =
    `rolling_zscore method requested but only ${prevHistory.length}d of history available (need ${minHistoryDays}d)`;
} else if (useRollingZScore) {
  anomaly_detection_method = 'rolling_zscore';

  // Build per-event count series from history (oldest → newest)
  const sortedHistory = [...prevHistory].sort((a, b) =>
    String(a.date ?? '').localeCompare(String(b.date ?? '')));

  const todayCount = (name) => ga4Events[name]?.count ?? 0;

  // Collect unique event names across history + current
  const eventUniverse = new Set([
    ...Object.keys(ga4Events),
    ...sortedHistory.flatMap(h => Object.keys(h.counts ?? {})),
  ]);

  const sameDayLastWeekIdx     = sortedHistory.length - 7;
  const sameDayFourWeeksAgoIdx = sortedHistory.length - 28;

  for (const name of eventUniverse) {
    const series = sortedHistory.map(h => h.counts?.[name] ?? 0);
    const current = todayCount(name);

    // Skip events with no historical signal at all
    const seriesMax = Math.max(...series, 0);
    if (seriesMax === 0 && current === 0) continue;

    // ── Baseline 1: rolling 7d mean + standard deviation z-score ──
    const recent7 = series.slice(-7);
    const mean7 = recent7.reduce((a, b) => a + b, 0) / Math.max(recent7.length, 1);
    const variance7 = recent7.reduce((a, b) => a + (b - mean7) ** 2, 0) / Math.max(recent7.length, 1);
    const std7 = Math.sqrt(variance7);
    const zScore = std7 > 0 ? (current - mean7) / std7 : 0;
    const flagZScore = std7 > 0 && Math.abs(zScore) > zThreshold;

    // ── Baseline 2: same-day-last-week ──
    const sameDayLastWeek = sameDayLastWeekIdx >= 0 ? series[sameDayLastWeekIdx] : null;
    const dropPctLastWeek = (sameDayLastWeek != null && sameDayLastWeek > 0)
      ? ((current - sameDayLastWeek) / sameDayLastWeek) * 100
      : null;
    const flagLastWeek = dropPctLastWeek != null && Math.abs(dropPctLastWeek) >= dropFloorPct;

    // ── Baseline 3: same-day-4-weeks-ago ──
    const sameDay4wAgo = sameDayFourWeeksAgoIdx >= 0 ? series[sameDayFourWeeksAgoIdx] : null;
    const dropPct4wAgo = (sameDay4wAgo != null && sameDay4wAgo > 0)
      ? ((current - sameDay4wAgo) / sameDay4wAgo) * 100
      : null;
    const flag4wAgo = dropPct4wAgo != null && Math.abs(dropPct4wAgo) >= dropFloorPct;

    const flagsTriggered = [flagZScore, flagLastWeek, flag4wAgo].filter(Boolean).length;

    if (flagsTriggered >= 2) {
      anomalies.push({
        event           : name,
        current_count   : current,
        rolling_mean_7d : Math.round(mean7),
        z_score         : Number(zScore.toFixed(2)),
        same_day_last_week     : sameDayLastWeek,
        drop_pct_last_week     : dropPctLastWeek != null ? Math.round(dropPctLastWeek) : null,
        same_day_4_weeks_ago   : sameDay4wAgo,
        drop_pct_4_weeks_ago   : dropPct4wAgo != null ? Math.round(dropPct4wAgo) : null,
        flags_triggered : {
          z_score: flagZScore, last_week: flagLastWeek, four_weeks_ago: flag4wAgo,
        },
        in_spec         : specNames.has(name),
      });
    }
  }
  anomalies.sort((a, b) => Math.abs(b.z_score ?? 0) - Math.abs(a.z_score ?? 0));
} else {
  // ── Binary fallback (legacy): previously >100, now 0 ──
  for (const [name, prevCount] of Object.entries(prevCounts)) {
    if (prevCount > 100) {
      const current = ga4Events[name]?.count ?? 0;
      if (current === 0) {
        anomalies.push({
          event          : name,
          previous_count : prevCount,
          current_count  : 0,
          in_spec        : specNames.has(name),
        });
      }
    }
  }
  anomalies.sort((a, b) => b.previous_count - a.previous_count);
}

// ── 10. Coverage stats ────────────────────────────────────────────────────────
const total_spec_events = specNames.size;
const implemented       = total_spec_events - missing_events.length;
const coverage_pct      = total_spec_events > 0
  ? Math.round((implemented / total_spec_events) * 100)
  : 0;

// ── 11. Flat lookup maps ──────────────────────────────────────────────────────
const event_counts = {};
const event_users  = {};
for (const [name, vals] of Object.entries(ga4Events)) {
  event_counts[name] = vals.count;
  event_users[name]  = vals.users;
}

// ── 12. Summary flags ─────────────────────────────────────────────────────────
const gaps_found       = missing_events.length > 0;
const anomalies_found  = anomalies.length > 0;
const all_clear        = !gaps_found && !anomalies_found;

// ── 13. Return ────────────────────────────────────────────────────────────────
return [{
  json: {
    client          : spec.client        ?? null,
    ga4_property    : spec.ga4_property  ?? null,
    run_date        : new Date().toISOString().slice(0, 10),
    coverage_pct,
    total_spec_events,
    implemented,
    missing_events,
    unexpected_events,
    anomalies,
    anomaly_detection : {
      method  : anomaly_detection_method,
      skipped : anomaly_detection_skipped_reason,
      history_days_available : prevHistory.length,
    },
    gaps_found,
    anomalies_found,
    all_clear,
    event_counts,
    event_users,
  }
}];
