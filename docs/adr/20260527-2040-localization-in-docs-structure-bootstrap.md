# Localization Support in the `docs-structure` Bootstrap

**Status:** Accepted
**Date:** 20260527-2040

The `docs-structure` bootstrap flow now prompts for documentation language and writes a fully localized `docs/project-docs-structure.md` (including prose and format templates). English and Traditional Chinese (`zh-tw`) are bundled hand-written; other locales are supported best-effort via runtime translation.

## Context

`docs/draft/Thoughts-localization.md` proposed that teams writing documentation in Traditional Chinese should be able to initialize a repository into that locale rather than receiving English-only templates. The existing bootstrap wrote nothing — it only printed a copy-pasteable English block — and the bundled content had no locale concept.

A design session (see `docs/draft/PLAN-localization.md`) explored approaches. The session also revealed a conflict: an earlier draft of the plan proposed writing templates as separate files under `docs/templates/`, which ADR `20260527-1559` had explicitly rejected in favor of inline embedding for reduced tool calls. The approach here honors that ADR.

## Decision

1. **Locale-aware bootstrap**: The bootstrap prompts for language before writing `docs/project-docs-structure.md`. Options: `1. English`, `2. 繁體中文 (zh-tw)`, `3. Other`. The written file includes `locale: <choice>` YAML frontmatter.

2. **Bootstrap writes the file**: The "No Docs Found" path now writes `docs/project-docs-structure.md` directly (working-tree change, no commit) instead of only printing a copy-pasteable block.

3. **Templates stay embedded inline**: Localized format templates (ADR, Context/Glossary, Incident) remain embedded as code blocks inside `docs/project-docs-structure.md`. No `docs/templates/` folder. This keeps ADR `20260527-1559` intact.

4. **Whole structure file localized**: For a `zh-tw` repo, the entire generated file — layout description, naming conventions, cross-cutting rules, and all three format templates — is in Traditional Chinese.

5. **Locale governs generated artifact content only**: `locale:` in the frontmatter directs which language the agent uses when authoring ADRs, incidents, CONTEXT entries, and design docs. The agent's conversation/interview language is unchanged; command instruction bodies stay English.

6. **Centralized locale rule, no per-command edits**: One cross-cutting rule (rule 8) in both bundled payloads carries the locale contract. `grill-with-doc`, `trouble-shoot-with-doc`, `sync-with-doc`, and `review-with-doc` are untouched — they inherit locale automatically via the localized templates in the repo's structure file.

7. **Single bundled locale**: Only English is bundled in `docs-structure/SKILL.md`. All non-English locales (including zh-tw) are produced by translating the English payload at runtime during bootstrap. The written file includes a note that the locale was machine-translated at bootstrap time and may need review.

8. **Lifecycle**: No new lifecycle mechanism. The opt-in `sync-with-doc` and `review-with-doc` commands already make the lifecycle non-intrusive; no additional tooling is needed.

## Consequences

**Positive:**
- Teams working in Traditional Chinese can initialize a fully localized doc structure without manual template translation.
- The single cross-cutting rule is the only contract; all commands stay forward-compatible with any locale added later.
- Bundled templates guarantee quality phrasing for the two primary locales with zero runtime translation overhead.

**Negative / trade-offs:**
- Non-English locales depend on LLM translation quality at bootstrap time; the generated `project-docs-structure.md` may need manual review for phrasing. The in-file note makes this expectation visible to the developer.

## Alternatives considered

- **Separate `docs/templates/` files**: Rejected — conflicts with ADR `20260527-1559` (inline embedding for single-tool-call reads and no folder clutter).
- **Translate this repo's docs to zh-tw**: Rejected — `auto-doc-flow` is an English project. The feature is a skill capability for bootstrapping other repos.
- **Locale governs conversation language too**: Rejected — command bodies stay English; only generated artifact content (the docs) is localized. This avoids surprising language switches mid-session.
- **Per-command locale edits**: Rejected — redundant once a single cross-cutting rule exists in the bundled payload.
- **Bundle multiple locale payloads in SKILL.md**: Rejected — bloats the user-scope skill. The generated `project-docs-structure.md` is a one-time scaffold that a developer can refine; runtime translation at bootstrap is sufficient and keeps SKILL.md lean.
