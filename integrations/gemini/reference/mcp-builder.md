# mcp-builder


# MCP Server Development Guide

## Overview

Create high-quality MCP servers that enable LLMs to effectively interact with external services. Quality is measured by how well the server enables LLMs to accomplish real-world tasks.

## High-Level Workflow

### Phase 1: Deep Research and Planning

**Agent-Centric Design Principles:**
- Build for workflows, not just API endpoints — consolidate related operations
- Optimize for limited context — return high-signal information, not data dumps
- Design actionable error messages that guide agents toward correct usage
- Follow natural task subdivisions — tool names should reflect how humans think

**Study the documentation:**
1. Fetch MCP protocol docs: `https://modelcontextprotocol.io/llms-full.txt`
2. Read `reference/mcp_best_practices.md`
3. For Python: read `reference/python_mcp_server.md`
4. For TypeScript: read `reference/node_mcp_server.md`

**Create implementation plan:** Tool selection, shared utilities, input/output design, error handling strategy.

### Phase 2: Implementation

1. Set up project structure (see language-specific guides in `reference/`)
2. Implement core infrastructure first (API helpers, error handling, pagination)
3. Implement tools systematically with input schemas, comprehensive docstrings, and tool annotations

**Tool annotations:** `readOnlyHint`, `destructiveHint`, `idempotentHint`, `openWorldHint`

### Phase 3: Review and Refine

- DRY principle, composability, consistency, error handling, type safety, documentation
- Test safely (MCP servers are long-running — use evaluation harness or tmux)

### Phase 4: Create Evaluations

Create 10 evaluation questions that are independent, read-only, complex, realistic, verifiable, and stable.

## Reference Files

- `reference/mcp_best_practices.md` — Universal MCP guidelines
- `reference/python_mcp_server.md` — Python/FastMCP implementation guide
- `reference/node_mcp_server.md` — TypeScript implementation guide
- `reference/evaluation.md` — Evaluation creation guide

---

# Mcp Builder Reference

Reference data, benchmarks, and platform-specific details for the Mcp Builder skill.

<!-- TODO: Add platform API schemas, benchmark data, and domain-specific reference tables -->
