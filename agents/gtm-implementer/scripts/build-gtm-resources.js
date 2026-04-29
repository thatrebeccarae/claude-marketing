// n8n Code node: Build GTM Resource Payloads
// Transforms Claude's gap analysis + event spec into GTM API-ready payloads for
// variables, triggers, and tags.
//
// Inputs:
//   $('Parse Gap Analysis').first().json.claude_analysis  — Claude's gap analysis
//   $('Read Event Spec').first().json.data                — Event spec (ground truth for GTM config)
//   $('Read Config').first().json                         — Client config (gtm.account_id, gtm.container_id)
//   $input.first().json                                   — Workspace creation response (workspaceId)
//
// The SPEC wins over Claude for all GTM config details.
// Events in Claude's analysis that don't exist in the spec are skipped.

// ── 1. Pull inputs ────────────────────────────────────────────────────────────
const workspaceResponse = $input.first().json;
const claudeAnalysis    = $('Parse Gap Analysis').first().json.claude_analysis;
const specRaw           = $('Read Event Spec').first().json.data;
const config            = $('Read Config').first().json;

const workspaceId = workspaceResponse.workspaceId ?? workspaceResponse.workspace?.workspaceId ?? '';

// ── 2. Parse event spec ───────────────────────────────────────────────────────
const spec = typeof specRaw === 'string' ? JSON.parse(specRaw) : specRaw;

// ── 3. Build spec lookup by event name ───────────────────────────────────────
// Preserves full GTM config from the spec — this is the source of truth.
const specLookup = {};

for (const group of (spec.event_groups || [])) {
  for (const ev of (group.events || [])) {
    if (ev.name) {
      specLookup[ev.name] = {
        name               : ev.name,
        gtm_trigger_type   : ev.gtm?.trigger_type   ?? 'CUSTOM_EVENT',
        gtm_tag_type       : ev.gtm?.tag_type        ?? 'gaawe',
        requires_datalayer : ev.gtm?.requires_datalayer ?? false,
        datalayer_variables: Array.isArray(ev.gtm?.datalayer_variables) ? ev.gtm.datalayer_variables : [],
        required_params    : Array.isArray(ev.required_params) ? ev.required_params : [],
        fires_on           : ev.gtm?.fires_on        ?? null,
      };
    }
  }
}

// ── 4. Collect all events requested by Claude's analysis ─────────────────────
// Sources: quick_wins[] and phases[].events[]
// We deduplicate by event name so the same event isn't created twice.
const requestedNames = new Set();
const skippedEvents  = [];

// From quick_wins (always included)
for (const qw of (claudeAnalysis.quick_wins || [])) {
  const name = qw.event_name;
  if (name) requestedNames.add(name);
}

// From phases — only include Phase 1 to keep workspace focused and within
// n8n Code node timeout. Later phases can be triggered in subsequent runs.
const MAX_PHASE = 1;
for (const phase of (claudeAnalysis.phases || [])) {
  if ((phase.phase_number ?? 99) > MAX_PHASE) continue;
  for (const ev of (phase.events || [])) {
    const name = ev.name;
    if (name) requestedNames.add(name);
  }
}

// Filter to only events that exist in the spec; log skips
const eventsToImplement = [];
for (const name of requestedNames) {
  if (specLookup[name]) {
    eventsToImplement.push(specLookup[name]);
  } else {
    skippedEvents.push({
      event_name : name,
      reason     : 'Not found in event spec — skipped to prevent untracked GTM resources',
    });
  }
}

// ── 5. Build Variables ────────────────────────────────────────────────────────
// Variables are dataLayer variable references. Deduplicate across all events.
// Naming: dlv_{variable_name}
const seenVarNames = new Set();
const variables    = [];

for (const ev of eventsToImplement) {
  for (const dlvKey of ev.datalayer_variables) {
    if (!seenVarNames.has(dlvKey)) {
      seenVarNames.add(dlvKey);
      variables.push({
        name      : `dlv_${dlvKey}`,
        type      : 'v',
        parameter : [
          { type: 'TEMPLATE', key: 'name',               value: dlvKey },
          { type: 'INTEGER',  key: 'dataLayerVersion',   value: '2'    },
        ],
      });
    }
  }

  // Also create variables for required_params that may not be in datalayer_variables
  // (spec may list them separately; deduplicate against what we've already queued)
  for (const param of ev.required_params) {
    if (!seenVarNames.has(param)) {
      seenVarNames.add(param);
      variables.push({
        name      : `dlv_${param}`,
        type      : 'v',
        parameter : [
          { type: 'TEMPLATE', key: 'name',               value: param },
          { type: 'INTEGER',  key: 'dataLayerVersion',   value: '2'  },
        ],
      });
    }
  }
}

// ── 6. Build Triggers ─────────────────────────────────────────────────────────
// One trigger per event. Type determined by spec's gtm_trigger_type.
const triggers = [];

for (const ev of eventsToImplement) {
  const triggerType = ev.gtm_trigger_type.toUpperCase();

  if (triggerType === 'CUSTOM_EVENT') {
    triggers.push({
      name              : `CE - ${ev.name}`,
      type              : 'CUSTOM_EVENT',
      customEventFilter : [
        {
          type      : 'EQUALS',
          parameter : [
            { type: 'TEMPLATE', key: 'arg0', value: '{{_event}}'  },
            { type: 'TEMPLATE', key: 'arg1', value: ev.name       },
          ],
        },
      ],
    });

  } else if (triggerType === 'PAGEVIEW') {
    const trigger = {
      name : `PV - ${ev.name}`,
      type : 'PAGEVIEW',
    };
    // If spec specifies a path pattern, add a page hostname/path filter
    if (ev.fires_on) {
      trigger.filter = [
        {
          type      : 'CONTAINS',
          parameter : [
            { type: 'TEMPLATE', key: 'arg0', value: '{{Page Path}}' },
            { type: 'TEMPLATE', key: 'arg1', value: ev.fires_on     },
          ],
        },
      ];
    }
    triggers.push(trigger);

  } else if (triggerType === 'CLICK') {
    triggers.push({
      name : `Click - ${ev.name}`,
      type : 'CLICK',
    });

  } else if (triggerType === 'LINK_CLICK') {
    triggers.push({
      name : `Link Click - ${ev.name}`,
      type : 'LINK_CLICK',
    });

  } else if (triggerType === 'FORM_SUBMISSION') {
    triggers.push({
      name : `Form - ${ev.name}`,
      type : 'FORM_SUBMISSION',
    });

  } else {
    // Unknown trigger type — default to CUSTOM_EVENT with a warning comment
    triggers.push({
      name              : `CE - ${ev.name}`,
      type              : 'CUSTOM_EVENT',
      customEventFilter : [
        {
          type      : 'EQUALS',
          parameter : [
            { type: 'TEMPLATE', key: 'arg0', value: '{{_event}}'  },
            { type: 'TEMPLATE', key: 'arg1', value: ev.name       },
          ],
        },
      ],
      _unknown_trigger_type_warning : `Spec specified "${ev.gtm_trigger_type}" — fell back to CUSTOM_EVENT`,
    });
  }
}

// ── 7. Build Tags ─────────────────────────────────────────────────────────────
// First: GA4 Configuration tag (gaawc) — required before event tags.
// Event tags reference it via TAG_REFERENCE.
const measurementId = config?.gtm?.measurement_id;
const GA4_CONFIG_TAG_NAME = 'GA4 Configuration';

const tags = [];

if (measurementId) {
  tags.push({
    name             : GA4_CONFIG_TAG_NAME,
    type             : 'gaawc',
    parameter        : [
      { type: 'TEMPLATE', key: 'measurementId', value: measurementId },
    ],
    firingTriggerId  : ['2147479553'],  // Built-in "All Pages" trigger
    _is_config_tag   : true,
  });
}

// One GA4 event tag per event. References trigger by name (_trigger_name) so
// a downstream node can resolve IDs after triggers are created.

for (const ev of eventsToImplement) {
  const triggerType = ev.gtm_trigger_type.toUpperCase();

  // Resolve the trigger name that matches what we built above
  let triggerName;
  if (triggerType === 'CUSTOM_EVENT') {
    triggerName = `CE - ${ev.name}`;
  } else if (triggerType === 'PAGEVIEW') {
    triggerName = `PV - ${ev.name}`;
  } else if (triggerType === 'CLICK') {
    triggerName = `Click - ${ev.name}`;
  } else if (triggerType === 'LINK_CLICK') {
    triggerName = `Link Click - ${ev.name}`;
  } else if (triggerType === 'FORM_SUBMISSION') {
    triggerName = `Form - ${ev.name}`;
  } else {
    triggerName = `CE - ${ev.name}`;
  }

  // Build eventParameters LIST from required_params
  // Each param maps to its corresponding dlv_ variable reference
  const eventParameterMaps = ev.required_params.map(param => ({
    type : 'MAP',
    map  : [
      { type: 'TEMPLATE', key: 'name',  value: param              },
      { type: 'TEMPLATE', key: 'value', value: `{{dlv_${param}}}` },
    ],
  }));

  const tagParameters = [
    { type: 'TEMPLATE', key: 'eventName', value: ev.name },
  ];

  if (eventParameterMaps.length > 0) {
    tagParameters.push({
      type : 'LIST',
      key  : 'eventParameters',
      list : eventParameterMaps,
    });
  }

  tagParameters.push({
    type  : 'TAG_REFERENCE',
    key   : 'measurementId',
    value : 'GA4 Configuration',
  });

  tags.push({
    name             : `GA4 Event - ${ev.name}`,
    type             : ev.gtm_tag_type ?? 'gaawe',
    parameter        : tagParameters,
    _trigger_name    : triggerName,   // used downstream to set firingTriggerId after triggers are created
    tagFiringOption  : 'ONCE_PER_EVENT',
  });
}

// ── 8. AEO scaffold (ai_referral) ─────────────────────────────────────────────
// When clientConfig.aeo_tracking_enabled is true, append a self-contained
// scaffold for tracking LLM-referred traffic. This complements the gap
// analyzer's recommendation: the gap analyzer flags `ai_referral` as a
// missing event in `quick_wins`, and this builder constructs the actual
// GTM resources (Custom JS variable matching the AI host regex, a trigger
// keyed on referrer match, and a GA4 Event tag posting the matched host).
//
// Idempotent — execute-gtm-writes.js skips resources whose names already
// exist in the workspace, so re-runs don't duplicate.
const aeoEnabled = config?.aeo_tracking_enabled === true;
const aeoEventName = 'ai_referral';

// Skip if the spec already defines ai_referral — the spec is the source of
// truth and the standard event-builder above would have handled it.
const aeoAlreadyInSpec = !!specLookup[aeoEventName];

if (aeoEnabled && !aeoAlreadyInSpec) {
  // ── Custom JavaScript variable: AI Referrer Host ────────────────────────
  // Returns the matched AI host (e.g., "chatgpt.com") or empty string.
  // Embedded as a single-line JS source for GTM's `jsm` variable type.
  const aiReferrerJs = [
    'function() {',
    '  var ref = document.referrer || "";',
    '  var host = "";',
    '  try { host = new URL(ref).hostname.replace(/^www\\./, ""); } catch (e) { return ""; }',
    '  var ai = /^(chatgpt\\.com|chat\\.openai\\.com|claude\\.ai|perplexity\\.ai|gemini\\.google\\.com|copilot\\.microsoft\\.com|grok\\.com|x\\.ai|meta\\.ai|you\\.com)$/i;',
    '  return ai.test(host) ? host : "";',
    '}',
  ].join('\n');

  variables.push({
    name      : 'cjs_ai_referrer_host',
    type      : 'jsm',
    parameter : [
      { type: 'TEMPLATE', key: 'javascript', value: aiReferrerJs },
    ],
  });

  // ── Trigger: fires when AI Referrer Host is non-empty (page view) ───────
  triggers.push({
    name   : `PV - ${aeoEventName}`,
    type   : 'PAGEVIEW',
    filter : [
      {
        type      : 'CONTAINS',
        parameter : [
          { type: 'TEMPLATE', key: 'arg0', value: '{{cjs_ai_referrer_host}}' },
          { type: 'TEMPLATE', key: 'arg1', value: '.' },  // any non-empty value contains a dot (TLD)
        ],
      },
    ],
  });

  // ── GA4 Event tag: ai_referral ──────────────────────────────────────────
  if (measurementId) {
    tags.push({
      name      : `GA4 Event - ${aeoEventName}`,
      type      : 'gaawe',
      parameter : [
        { type: 'TEMPLATE', key: 'eventName', value: aeoEventName },
        {
          type : 'LIST',
          key  : 'eventParameters',
          list : [
            {
              type : 'MAP',
              map  : [
                { type: 'TEMPLATE', key: 'name',  value: 'ai_referrer_host' },
                { type: 'TEMPLATE', key: 'value', value: '{{cjs_ai_referrer_host}}' },
              ],
            },
          ],
        },
        { type: 'TAG_REFERENCE', key: 'measurementId', value: 'GA4 Configuration' },
      ],
      _trigger_name   : `PV - ${aeoEventName}`,
      tagFiringOption : 'ONCE_PER_EVENT',
      _is_aeo_scaffold: true,
    });
  } else {
    skippedEvents.push({
      event_name : aeoEventName,
      reason     : 'AEO scaffold requested but no measurement_id in client config — GA4 Configuration tag dependency unavailable',
    });
  }
}

// ── 9. Return ─────────────────────────────────────────────────────────────────
const totalResources = variables.length + triggers.length + tags.length;

return [{
  json: {
    workspace_id         : workspaceId,
    account_id           : config?.gtm?.account_id   ?? null,
    container_id         : config?.gtm?.container_id ?? null,
    variables,
    triggers,
    tags,
    total_resources      : totalResources,
    estimated_seconds    : totalResources * 4,
    events_to_implement  : eventsToImplement.map(ev => ev.name),
    aeo_scaffold_built   : aeoEnabled && !aeoAlreadyInSpec && !!measurementId,
    _skipped_events      : skippedEvents,
  },
}];
