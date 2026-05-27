# Claude Code — settings & build

This directory holds the Claude Code–specific side of the doc-flow plugin.

## Layout

```
src/claude-code/
├── build.sh            # generator: merges settings + universal bodies → dist/
├── plugin/             # plugin metadata (static source)
│   ├── plugin.json
│   └── marketplace.json
├── commands/           # per-command settings (frontmatter fields; body notes optional)
│   └── <name>.json     # {"description": "...", "custom_notes": [...]}  ← custom_notes optional
├── skills/             # per-skill settings
│   └── <name>.json     # {"name": "...", "description": "..."}
└── dist/               # GENERATED — the assembled Claude Code plugin (gitignored)
    ├── .claude-plugin/
    ├── commands/*.md
    └── skills/<name>/SKILL.md
```

## Building

```bash
bash src/claude-code/build.sh
```

The script reads each `commands/<name>.json` and `skills/<name>.json`, combines the
settings with the matching body from `src/universal/`, and writes the fully assembled
`.md` files into `dist/`. An optional `"custom_notes"` array in the settings JSON is
stripped from the frontmatter and appended to the body as a `## Custom Notes` section.
Plugin metadata is copied verbatim from `plugin/`.

## Validating & loading

```bash
# validate the generated plugin
claude plugin validate src/claude-code/dist

# load for the current session only (no install step)
claude --plugin-dir src/claude-code/dist
```

## Invoking commands

After install or `--plugin-dir`, commands are available under the `adf:` prefix:

```
/adf:grill-with-doc
/adf:brain-storm-with-doc
/adf:review-with-doc
/adf:sync-with-doc
/adf:trouble-shoot-with-doc
```

## Adding a new command or skill

1. Add the body `.md` to `src/universal/commands/<name>.md` (no frontmatter).
2. Add `src/claude-code/commands/<name>.json` with `{"description": "..."}` (and optionally `"custom_notes": [...]` for agent-specific runtime instructions).
3. Run `bash src/claude-code/build.sh`.
