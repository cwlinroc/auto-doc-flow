# Docs Structure

This is a user-scope skill. It gives doc-producing commands a minimal, sensible default for how to think about documentation. It is **not** the final authority for any specific repository.

## Local Authority Routing

At the start of any documentation workflow, you **MUST** check if the repository defines its own documentation rules:
1. Check if the file **`docs/project-docs-structure.md`** exists in the current workspace using your file-viewing or directory-listing tools.
2. If it **does exist**, immediately read it. Defer to it as the absolute local authority on folder layouts, document naming rules, format templates, and cross-cutting rules. Fully override the global `docs-structure` baseline rules.
3. If it **does not exist**, execute the **Bootstrapping Flow** described below.

---

## Recommended Baseline (Fallback Only)

If `docs/project-docs-structure.md` is missing, the default documentation baseline layout is:

- `README.md` — entry point and quick orientation.
- `docs/adr/` — Architecture Decision Records: decisions that are hard to reverse or hard to understand later without context.
- `docs/design/` — designs still under exploration: alternatives, tradeoffs, open questions.
- `docs/reference/` — technical facts, copied sources, and external material worth keeping near the project.
- `docs/CONTEXT.md` or equivalent — shared terminology and business context. Glossary only.
- `docs/draft/` — personal scratch for work not yet ready to become team-facing documentation.

### When to Use Which Doc (Fallback Only)

- **Confirmed, hard-to-reverse decision** → ADR. Still exploring? → design doc.
- **Technical fact about a system we built or use** → reference doc.
- **Shared terminology or business context** → CONTEXT.md or equivalent.
- **Still thinking** → draft. Graduate to `docs/` only when the content is something the team should be able to find.

---

## Bootstrapping Flow

When `docs/project-docs-structure.md` is missing, follow these steps:

1. **Fast Scan**: Check top-level folders and files (e.g., `docs/`, `doc/`, `README.md`) using your directory-listing or file-viewing tools to detect if any documentation exists. Do NOT run expensive repository-wide scans.
2. **Existing Docs Found**: If existing documentation files exist, analyze their current folder structure and naming conventions. Propose a customized `docs/project-docs-structure.md` file designed to preserve and standardize their existing style.
3. **No Docs Found**: If no documentation exists in the repository, advise the user that they can customize the documentation rules for this project by creating `docs/project-docs-structure.md`. Output the following copy-pasteable default configuration to help them bootstrap:

```markdown
# Project Docs Structure

This file is the local authority on how docs are organized in this repository. Use it together with `docs-structure`; when the two conflict, follow this file.

## Target Layout

\`\`\`text
.
├── README.md
└── docs/
    ├── CONTEXT.md      # glossary ONLY — shared terminology, no implementation detail
    ├── adr/            # Architecture Decision Records
    ├── design/         # designs under exploration
    ├── domain/         # business context: customers, SLAs, seasonality, domain rules
    ├── incident/       # blameless incident records
    ├── reference/      # technical reference + raw source material
    └── draft/          # gitignored scratch
\`\`\`

## What Goes Where

- `README.md` — entry point and quick orientation.
- `docs/CONTEXT.md` — glossary and shared terminology, nothing else. No implementation detail, no specs, no scratch notes. See the Context Format template below.
- `docs/adr/` — decisions that are hard to reverse or hard to understand without context. See the ADR Format template below.
- `docs/design/` — designs and tradeoffs still being worked through.
- `docs/domain/` — business context: who uses this system, under what constraints, seasonal patterns, SLAs.
- `docs/incident/` — blameless incident records. See the Incident Format template below.
- `docs/reference/` — technical reference material and raw source documents worth keeping near the project. Store verbatim; optionally add a separate summary that cites it.
- `docs/draft/` — early thoughts, rough plans, personal scratch. Gitignored. Not team-facing.

## Naming Conventions

| Doc type | Pattern | Example |
|---|---|---|
| ADR | \`YYYYMMDD-hhmm-<slug>.md\` | \`20260525-1430-use-postgres-for-write-model.md\` |
| Incident | \`YYYYMMDD-hhmm-<slug>.md\` | \`20260525-0910-payment-timeout-prod.md\` |
| Draft | \`Thoughts-<topic>.md\` / \`Problem-<topic>.md\` / \`PLAN-<topic>.md\` | \`PLAN-auth-rework.md\` |
| Everything else | lowercase kebab-case | \`checkout-flow.md\` |

**Getting the timestamp:** Run the date-getting shell command yourself first (e.g., \`Get-Date -Format "yyyyMMdd-HHmm"\` in PowerShell or \`date +%Y%m%d-%H%M\` in bash). Only ask the engineer if command execution is unavailable or fails.

---

## Cross-Cutting Rules for All Commands

1. **Never auto-commit.** All output is a working-tree change for the engineer to review.
2. **Lazy folder creation.** Only create \`docs/adr/\`, \`docs/incident/\`, etc. when the first file in that folder is needed.
3. **ADRs and incidents are immutable.** Never edit original content. Corrections and follow-ups are appended as dated notes at the bottom of the file.
4. **Raw sources go in \`reference/\` verbatim.** When the engineer provides third-party API docs, spec excerpts, or other source material, offer to store the raw source (preferred) plus optionally a summary that cites it.
5. **Conflict with existing docs.** If new content contradicts an existing ADR, surface the conflict before writing. If confirmed outdated, append a dated correction note — do not rewrite the original.
6. **Default to \`docs/draft/\`.** When unsure whether a doc should exist, write to \`docs/draft/\` first and ask before graduating to \`docs/\`.
7. **Human intent before automation.** Ask when the target doc type is unclear.
```

---

## Rules for Commands

1. **Never auto-commit.** All output is a working-tree change for the engineer to review.
2. The engineer decides what is worth documenting. Commands ask; the engineer supplies substance. Do not invent content.
