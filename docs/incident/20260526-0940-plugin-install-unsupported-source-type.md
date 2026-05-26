# Plugin install fails: "source type your Claude Code version does not support"

**Occurred:** 20260526-0940
**Level:** while-dev

Running `bash install-plugin.sh` failed at the `claude plugin install` step with a
misleading error blaming the Claude Code version, when the actual cause was an invalid
`source` string in `marketplace.json`.

## Symptoms

```
Installing plugin "auto-doc-flow@auto-doc-flow"...
✘ Failed to install plugin "auto-doc-flow@auto-doc-flow": This plugin uses a source type
  your Claude Code version does not support. Update Claude Code and try again.
```

`install-plugin.sh` successfully registered the marketplace (`marketplace add` returned ✔)
but the subsequent `plugin install` step failed every time.

## Timeline

- user reported: `install-plugin.sh` written as part of the initial plugin scaffolding.
- user reported: first run produced the error above.
- `claude plugin validate src/universal` run → confirmed `plugins.0.source: Invalid input`.
- Root cause identified: `"source": "."` in `marketplace.json`.
- `"source": "."` changed to `"source": "./"` in `marketplace.json`.
- `claude plugin validate src/universal` re-run → "Validation passed with warnings" (only
  cosmetic warning: missing top-level marketplace description).

## Observations

- Claude Code version at time of incident: **2.1.150** — current; not the actual problem.
- `claude plugin validate` is the correct diagnostic tool; it reported the exact field and
  error immediately.
- The official schema states: *"Must start with `./`"* for relative-path plugin sources.
- `"."` does not start with `"./"`, so the source-type parser found no matching type and
  produced the generic "unsupported source type / update Claude Code" error.
- The plugin lives at the marketplace root (`src/universal/` holds both `.claude-plugin/` and
  `commands/`+`skills/`), so `"./"` (not a deeper subdirectory path) is the correct value.

## Conclusion

The relative-path plugin source `"source": "."` is not a valid value. Claude Code requires
the string to start with `"./"`. A bare `"."` passes no source-type check and falls through
to the generic "unsupported source type" error. Fix: `"source": "./"`.

## Contributing factors

- The error message ("Update Claude Code") points to the wrong cause, sending the investigator
  in the wrong direction. `claude plugin validate` is needed to surface the real validation
  error.
- No schema enforcement at marketplace authoring time — the invalid value is only caught at
  install.

## What we learned

- When `plugin install` fails with "source type not supported / update Claude Code", run
  `claude plugin validate <marketplace-dir>` first. The error message is generic; validate
  gives the exact field that failed.
- Relative-path plugin sources in `marketplace.json` must start with `"./"` — a bare `"."`
  is invalid even though it is a valid directory reference in most Unix contexts.
- `--plugin-dir <path>` (`claude --plugin-dir src/universal`) is a better tool for iterating
  on local plugin development: ephemeral (session-only), no install step, no user-settings
  side effects, and bypasses `marketplace.json` entirely.

## Related

- Fix applied in: `src/universal/.claude-plugin/marketplace.json` (source `"."` → `"./"`)
- Fast-iteration script added: `test-plugin.sh` (uses `--plugin-dir`)

## Follow-up — 20260526

The "What we learned" example `claude --plugin-dir src/universal` is no longer valid.
`src/universal/` had its `.claude-plugin/` removed when the plugin was split into a build
pipeline (see ADR `20260526-1007-split-universal-vs-claude-code-build.md`). The updated
fast-iteration command is:

```
bash src/claude-code/build.sh && claude --plugin-dir src/claude-code/dist
```
