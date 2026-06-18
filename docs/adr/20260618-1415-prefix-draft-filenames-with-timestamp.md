# Prefix Draft Filenames with Timestamp

**Status:** Accepted
**Date:** 20260618-1415

All draft files generated under `docs/draft/` will now be prefixed with a `YYYYMMDD-hhmm-` timestamp, matching the chronological style used by ADRs and incident records.

## Context

Draft files in `docs/draft/` (such as `Thoughts-<topic>.md`, `Problem-<topic>.md`, and `PLAN-<topic>.md`) were previously named without any chronological prefix. As a project grows, it becomes harder to track the order of drafts or reference which draft led to which ADR/Incident. Adding a timestamp prefix, like we do for ADRs and incident logs, keeps the drafts organized and chronologically traceable.

## Decision

1. **Prefix Draft Filenames with Timestamp**: All draft filenames created in `docs/draft/` must start with a `YYYYMMDD-hhmm-` prefix (e.g. `20260618-1415-Thoughts-<topic>.md`).
2. **Preserve Prefix Capitalization**: The original naming patterns and capitalization (`Thoughts`, `Problem`, `PLAN`) are preserved behind the timestamp prefix:
   - `docs/draft/YYYYMMDD-hhmm-Thoughts-<topic>.md`
   - `docs/draft/YYYYMMDD-hhmm-Problem-<topic>.md`
   - `docs/draft/YYYYMMDD-hhmm-PLAN-<topic>.md`
3. **Update Skills and Commands**: All documentation conventions, command instructions, and default structure templates are updated to reflect and recommend this naming pattern.

## Consequences

- Chronological ordering is preserved naturally in directory listings.
- Draft files can be easily correlated with ADRs and Incidents created around the same time.
- Commands like `brain-storm-with-doc` and `trouble-shoot-with-doc` must first run the date-getting shell command to determine the prefix before writing a draft file.
