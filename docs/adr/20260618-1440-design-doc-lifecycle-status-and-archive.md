# Design-doc lifecycle: status frontmatter and archive/ subfolder

Design docs in `docs/design/` now carry a `status: active | in-progress | superseded` frontmatter field.
When a design is confirmed superseded, it is moved to `docs/design/archive/` rather than
deleted or moved to `docs/reference/`. This mirrors the explicit-status precedent set by ADRs
and preserves in-tree visibility and git history.

## Considered options

- **Move to `docs/reference/`** — rejected. `reference/` is defined as verbatim raw-source
  and technical-reference material. An outdated internal design doc is neither.
- **Delete after confirmation** — rejected. Deletion loses in-tree visibility; recovery
  requires navigating git history. Archiving costs nothing and keeps the document findable
  without a git command.
- **Mark in place, never move** — a valid alternative. Rejected in favour of a dedicated
  `archive/` subfolder so that `docs/design/` stays a clean list of active designs, reducing
  noise when the `organize-doc` command (or a reader) scans for live decisions.

## Consequences

- `docs/project-docs-structure.md` documents the `status:` field and `design/archive/`
  subfolder as part of the canonical layout.
- `docs/design/archive/` is created lazily — only when the first file is moved there.
- The `organize-doc` command depends on this convention: it runs an orientation scan of the
  project and uses the `status:` field and `archive/` subfolder to **archive obsolete design
  docs** (setting `status: superseded` before moving) and **rewrite drifted ones in place**
  (ensuring `status: active` or preserving `status: in-progress`). It does not merely identify and move pre-labelled superseded
  docs — it judges alignment from the scan.
