# MCP Builder — Examples

## Example 1: Build a Weather API MCP Server (Python)

### Prompt

> Create an MCP server in Python that wraps the OpenWeatherMap API with tools for current weather, 5-day forecast, and severe weather alerts.

### What the skill does

1. Reads `reference/python_mcp_server.md` for FastMCP patterns
2. Creates a server with 3 tools: `get_current_weather`, `get_forecast`, `get_weather_alerts`
3. Implements shared utilities (API client, response formatting, error handling)
4. Uses Pydantic models for input validation (city name, coordinates, units)
5. Returns concise, LLM-friendly responses (not raw API dumps)

---

## Example 2: Build a Database MCP Server (TypeScript)

### Prompt

> Create a TypeScript MCP server that provides read-only access to a PostgreSQL database with natural language query tools.

### What the skill does

1. Reads `reference/node_mcp_server.md` for TypeScript SDK patterns
2. Creates tools: `list_tables`, `describe_table`, `run_query` (read-only enforced)
3. Uses Zod schemas with `.strict()` for input validation
4. Implements query result truncation (25,000 token limit)
5. Adds tool annotations: `readOnlyHint: true`, `destructiveHint: false`

---

## Example 3: Add Tools to Existing Server

### Prompt

> I have an MCP server for GitHub. Add tools for managing pull request reviews and automated labeling.

### What the skill does

1. Reviews existing server code for patterns and shared utilities
2. Adds `review_pull_request` and `auto_label_pr` tools following existing conventions
3. Reuses the API client and error handling from existing tools
4. Creates evaluation questions to test the new tools
