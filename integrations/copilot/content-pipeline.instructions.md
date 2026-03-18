End-to-end content creation workflow that orchestrates research, editorial review, and social distribution agents in sequence. Use when the user wants to create, review, and distribute content through a multi-stage pipeline, or says "/content-pipeline".


# Content Pipeline

Orchestrate the full content creation workflow from research brief to published-ready content with social distribution pack.

## What This Skill Does

Chains up to 3 agents in sequence:
1. **research-analyst** — Generates a research brief on the topic
2. **editor-in-chief** — Reviews the draft against voice, structure, SEO, and argument quality
3. **social-amplifier** — Creates platform-specific distribution pack (LinkedIn, Twitter/X, email)

Users can enter at any stage or run the full pipeline.

> **How this differs from content-workflow:** The content-workflow skill is a manual workflow guide with frameworks and checklists. This skill is the *orchestration layer* — it actually spawns subagents and manages the pipeline programmatically.

## How to Use

```
/content-pipeline [topic or file path]
```

### Full Pipeline (from scratch)
```
/content-pipeline "Why MCP is the new API"
```

### Start from Existing Draft
```
/content-pipeline review ./drafts/article-draft.md
```

### Social Pack Only
```
/content-pipeline distribute ./content/published-article.md
```

## Workflow Stages

### Stage 1: Research (optional — skip if draft exists)
- Spawn research-analyst agent with the topic
- Output: `./research-briefs/YYYY-MM-DD-topic-slug.md`
- User reviews brief, decides whether to proceed

### Stage 2: Editorial Review
- Spawn editor-in-chief agent pointing at the draft/brief
- Output: `[draft-path]-review.md` saved alongside the source
- Agent provides: voice assessment, structure feedback, SEO evaluation, line-level notes, title variants
- User decides: publish as-is, revise, or iterate

### Stage 3: Social Distribution
- Spawn social-amplifier agent pointing at the final content
- Output: `[content-path]-social-pack.md` saved alongside the source
- Generates: LinkedIn posts (2 variants), Twitter/X thread, email subject lines, pull quotes, hashtags

## Configuration

### Customizing Agents

The default agent chain uses Claude Code subagents with the Agent tool. To customize:

```
Pipeline Stage    | Default Agent Type    | Override With
Research          | research-analyst      | Any research/analysis agent
Editorial         | editor-in-chief       | Any editorial review agent
Distribution      | social-amplifier      | Any social content agent
```

### Output Paths

Configure where each stage saves its output:

| Stage | Default Output Path |
|-------|-------------------|
| Research | `./research-briefs/YYYY-MM-DD-topic-slug.md` |
| Draft | `./content/YYYY/YYYY-MM-DD-slug.md` |
| Review | `[draft-path]-review.md` (alongside draft) |
| Social Pack | `[content-path]-social-pack.md` (alongside content) |

### Publishing Cadence

Adapt the pipeline to your publishing schedule. Example cadence:
- **Research**: Monday/Tuesday
- **Draft**: Tuesday/Wednesday
- **Review**: Wednesday/Thursday
- **Publish**: Thursday/Friday

## Pipeline State Management

The pipeline tracks which stages are complete via file existence:
- Research brief exists → Stage 1 complete
- Review file exists → Stage 2 complete
- Social pack exists → Stage 3 complete

Resume from any stage by pointing to existing files.

## Integration with Other Skills


(Truncated. See full skill at github.com/thatrebeccarae/claude-marketing)
