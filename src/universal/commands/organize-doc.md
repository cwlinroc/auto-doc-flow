# organize-doc

Read the `docs-structure` skill to understand general conventions and check for the local
`docs/project-docs-structure.md` file, which is the absolute authority on repository rules.

This command makes **no code changes** and **never auto-commits**. It is the *aggressive
realign* command — run when docs feel messy or drifted and you want them cleaned up and
reconciled with what the project actually is today.

- `sync-with-doc` is for mechanical reference fixes after a code change.
- `grill-with-doc` is for capturing new decisions via interrogation.
- `organize-doc` is for realigning an entire doc set against the current project.

## Operating model

1. **Orientation scan** — build a current-project model from the codebase.
2. **Build a realignment plan** — classify every doc, identify every fix.
3. **Preview the full plan** — present it to the engineer for approval.
4. **Apply on confirmation** — execute only what the engineer approved.
5. **Summarize** — report every action taken.

## Step 1 · Orientation scan

Read, in order:

- `README.md` and `AGENTS.md` (top-level)
- Top-level directory layout (project structure)
- Key module entry points or main source files

From these, produce a **current-project model**: what the project is, what its major
components are, what terminology is in active use. This is an orientation pass, not a
per-claim trace — do not crawl every implementation file. Use this model as the reference
for judging doc drift in every subsequent step.

## Step 2 · Design-doc realignment (`docs/design/`)

Scan `docs/design/` non-recursively (skip `archive/`). If the directory does not exist,
report it and skip this step.

For each file, read its content and frontmatter and compare it against the current-project
model. Assign a verdict:

| Verdict | Condition | Action |
|---|---|---|
| **aligned** | Content matches current project | Leave unchanged; ensure `status: active` or `status: in-progress` in frontmatter |
| **drifted** | Still relevant but no longer accurate | Rewrite in place to match reality; set `status: active` or preserve `status: in-progress` |
| **obsolete** | No longer relevant to the current project | Set `status: superseded`; move to `docs/design/archive/` |

An existing `status: superseded` field is a strong signal that the doc is obsolete. An
existing `status: active` or `status: in-progress` field is not dispositive — the scan can
still find it obsolete or drifted.

When rewriting in place, preserve the document's purpose and title. Update content to
reflect the current project; do not shrink the doc gratuitously. Rewriting from scratch
is allowed only if the original content is so stale it would mislead more than guide.

Create `docs/design/archive/` lazily — only when the first file is moved there.

**Never delete** a design doc. If the engineer asks to delete rather than archive, redirect:
archiving preserves in-tree visibility and git history at zero cost.

## Step 3 · Glossary alignment (`docs/CONTEXT.md`)

If the file does not exist, report it and skip this step.

**Auto-fix unambiguous formatting issues** (record each with a one-line reason):

- `**term**:` → `**Term**:` (capitalize first letter of term heading)
- `_avoid_:` / `Avoid:` / `_Avoid_` → `_Avoid_:` (normalize alias label)
- Extra blank lines between entries

**Detect structural issues** (flag, do not auto-fix):

- Duplicate or conflicting entries
- Terms with zero presence in the codebase (confirm with engineer before removing)
- Term *names* that differ from the names actually used in the code (flag as misaligned;
  propose the aligned name but do not rename without confirmation)

**Flag for human review — do NOT rewrite:**

- Definition prose, even if potentially misleading — intent matters more than accuracy here;
  this is not a domain-modeling session
- Any term that may be genuinely distinct despite a similar name

Never invent domain meaning from a code scan. If the glossary and the codebase conflict on
what a term means, surface the conflict and defer to the engineer.

## Step 4 · Immutable records (`docs/adr/`, `docs/incident/`)

Read ADRs and incident records. If a record appears to conflict with the current-project
model (a named technology is gone, a decision seems reversed), **flag it** and, after the
engineer confirms the drift:

1. Get the current timestamp: run `date +%Y%m%d-%H%M` (bash) or
   `Get-Date -Format 'yyyyMMdd-HHmm'` (PowerShell).
2. **Append** a dated correction note at the bottom of the file:

   ```markdown
   ## Correction (YYYYMMDD-hhmm)

   {What has changed since this record was written. One or two sentences.}
   ```

Never rewrite the original content of an ADR or incident record.

Leave `docs/reference/` entirely untouched — stored verbatim.

## Preview & confirm

Before applying any change, present the full realignment plan:

- Design docs to leave unchanged
- Design docs to rewrite in place (with a one-line reason each)
- Design docs to archive (with a one-line reason each)
- Glossary auto-fixes
- Glossary flags for human review
- ADR/incident correction notes proposed
- Any section skipped, with reason

Use `AskUserQuestion` to present the plan and request approval. Use `multiSelect: true` when
asking the engineer to confirm which design docs to rewrite or archive from a batch. For
open-ended decisions, ask one at a time. Apply only after explicit confirmation.

## Summarize

After applying, output:

- **Realigned / rewritten** — file, one-line reason per change.
- **Archived** — original path → `docs/design/archive/<filename>`.
- **Glossary auto-fixed** — term / issue, one-line reason.
- **Glossary flagged** — term / issue, reason.
- **Corrections appended** — file, one-line summary of the correction.
- **Flagged for human review** — file or term, reason.
- **Skipped** — any file or section not processed, with reason.

Do not commit.

## Next step

After applying, suggest: *"Run `review-with-doc` to review the realigned docs against the
codebase in depth, or `sync-with-doc` after your next code change."*

## Non-goals

- Per-claim source tracing — that is `sync-with-doc` and `review-with-doc`.
- Detecting whether a change is ADR-worthy — that is `grill-with-doc`.
- Deleting docs (archive instead).
- Rewriting immutable records (`adr/`, `incident/`) or verbatim source (`reference/`).
- Rewriting glossary definition prose or inventing domain meaning from a code scan.
- Auto-committing.
