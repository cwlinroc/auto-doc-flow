# Packaging-Time Agent Custom Notes

Introduce agent-specific customization instructions during the packaging/build phase by using a `"custom_notes"` array in settings JSON files, which the build scripts dynamically extract and append to the generated markdown body.

## Status
Accepted

## Context
Our documentation skills and commands (e.g. `grill-with-doc`, `brain-storm-with-doc`) are written as agent-agnostic markdown in `src/universal/` to maintain portability across multiple AI agents (Claude Code, Antigravity, Codex CLI, GitHub Copilot).

However, this vendor-lock prevention stops individual agents from natively leveraging their specialized features—such as Antigravity's structured `ask_question` tool and markdown artifacts (`IsArtifact: true` metadata), Claude Code's interactive terminal REPL, Codex CLI's non-interactive pipeline fallbacks, or GitHub Copilot's visual sidebar chat.

## Decision
Introduce a metadata-based compilation workflow (Option 3):
1. **Metadata JSON Directives**: Add a `"custom_notes"` string array property to the agent-specific settings JSON files under `src/<agent>/{commands,skills}/`.
2. **Build Compilation Flow**: Update the `build.sh` script for each agent to:
   - Filter out `"custom_notes"` from the compiled YAML frontmatter using `jq 'del(.custom_notes)'` to keep metadata clean.
   - Format and append these notes as a `## Custom Notes` bulleted list at the bottom of the generated markdown body.

## Consequences
- **Positive:**
  - Zero pollution of the universal instruction source code in `src/universal/`.
  - Settings and custom instructions are co-located in a single JSON file per skill/command.
  - Generates highly targeted prompt guides at the end of the markdown body, which modern LLMs heavily prioritize due to recency bias.
- **Negative:**
  - Instructions are strictly appended under a `## Custom Notes` heading rather than injected inline. This is a minor trade-off since system guidelines are best framed as end-of-document rules anyway.

## Alternatives considered

- **Option 1 — Inline agent-specific notes directly in `src/universal/` source.** Rejected: pollutes the agent-agnostic body with vendor-specific guidance and defeats the portability goal.
- **Option 2 — Maintain separate per-agent body copies** (e.g. `src/claude-code/commands/grill-with-doc.md`). Rejected: four-way duplication creates drift and makes cross-agent updates error-prone.
