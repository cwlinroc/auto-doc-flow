# Antigravity — settings & build

This directory holds the Antigravity-specific packaging and build/installer scripts for the `adf-plugin` plugin.

## Layout

```
src/antigravity/
├── build.sh            # generator: compiles settings + universal bodies → dist/
├── plugin.json         # plugin metadata
├── commands/           # settings JSON for universal commands (compiled as skills)
│   └── <name>.json     # {"name": "...", "description": "..."}
├── skills/             # settings JSON for universal skills
│   └── <name>.json     # {"name": "...", "description": "..."}
└── dist/               # GENERATED — the compiled Antigravity plugin (gitignored)
    ├── plugin.json
    └── skills/         # All commands and skills are packaged as native skills
        └── <name>/SKILL.md
```

## Building

```bash
bash src/antigravity/build.sh
```

The script compiles each settings JSON under `commands/` and `skills/` with their matching bodies from `src/universal/` and outputs them as skills inside `dist/skills/`. An optional `"custom_notes"` array in the settings JSON is stripped from the frontmatter and appended to the body as a `## Custom Notes` section.

## Installing

```bash
bash scripts/install-antigravity-plugin.sh
```

This compiles the plugin and copies the `dist/` files directly into your local Antigravity config directory at:
`%USERPROFILE%\.gemini\config\plugins\adf-plugin`
