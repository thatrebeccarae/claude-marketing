// n8n Code node: GTM Workspace Preflight Check
// Receives GTM List Workspaces API response and determines routing for workspace operations.
//
// Inputs:
//   $input.first().json         — HTTP response from GTM List Workspaces API
//                                 Shape: { workspace: [ { workspaceId, name, path, ... } ] }
//   $('Read Config').first().json — Client config with gtm.workspace_name_prefix (default "claude")

const apiResponse = $input.first().json;
const config = $('Read Config').first().json;

// --- 1. Parse workspace list ---
const workspaces = apiResponse.workspace || [];

// --- 2. Server-side GTM safety guard ---
// Server-side containers (sGTM v3.2.0+, Sept 2025) have a different resource
// model than web containers. The downstream tag/trigger/variable builders
// (build-gtm-resources.js) emit gaawe/gaawc payloads that don't apply to sGTM.
// Detect server-side by inspecting the API response and exit cleanly rather
// than create broken resources.
const looksServerSide =
  apiResponse.containerType === 'SERVER' ||
  apiResponse._container_usage_context === 'server' ||
  workspaces.some(ws => typeof ws.path === 'string' && ws.path.includes('serverContainers/'));

if (looksServerSide) {
  return [
    {
      json: {
        route: 'unsupported_container_type',
        reason: 'Server-side GTM container detected — gtm-implementer only supports web containers. Skipping GTM writes; preflight aborted.',
        workspace_count: workspaces.length,
        existing_agent_workspace: null,
        can_create: false,
        can_proceed: false,
        reuse_workspace_id: null,
        container_type: 'server',
      },
    },
  ];
}

// --- 3. Count total workspaces ---
const workspace_count = workspaces.length;

// --- 4. Resolve the prefix to match against ---
const prefix = (config?.gtm?.workspace_name_prefix ?? 'claude') + '-';

// --- 5. Check for an existing agent workspace ---
const found = workspaces.find(ws => ws.name && ws.name.startsWith(prefix)) || null;

const existing_agent_workspace = found
  ? {
      workspaceId: found.workspaceId,
      name: found.name,
      path: found.path,
    }
  : null;

// --- 6. Determine route ---
// GTM allows a maximum of 3 workspaces per container.
let route;
if (workspace_count >= 3) {
  route = 'workspace_limit';
} else if (existing_agent_workspace !== null) {
  route = 'existing_workspace';
} else {
  route = 'available';
}

// --- 7. Return result ---
// can_proceed: true if we have a workspace to use (new or existing)
const can_proceed = route === 'available' || route === 'existing_workspace';

return [
  {
    json: {
      route,                    // "available" | "workspace_limit" | "existing_workspace" | "unsupported_container_type"
      workspace_count,          // number
      existing_agent_workspace, // null or { workspaceId, name, path }
      can_create: route === 'available',
      can_proceed,              // true if we can continue to GTM writes
      container_type: 'web',
      // If reusing existing workspace, pass its ID so downstream nodes can use it
      reuse_workspace_id: existing_agent_workspace?.workspaceId ?? null,
    },
  },
];
