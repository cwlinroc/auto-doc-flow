# GitHub Copilot Packaging for ADF

This directory contains the settings and build script to package Auto Doc Flow skills and commands for GitHub Copilot (VS Code integrated agent).

## Layout

- `commands/` - JSON configuration files for universal commands (built as `.prompt.md` files).
- `skills/` - JSON configuration files for universal skills (built as `SKILL.md` in skill directories).
- `plugin.json` - Metadata description.
- `build.sh` - Assembles the prompts and skills from `src/universal/` and outputs them into `dist/`.

## Build

To compile the Copilot prompts and skills:
```bash
bash src/copilot/build.sh
```

This creates:
- `dist/prompts/` - Containing `.prompt.md` files for commands.
- `dist/skills/` - Containing skill directories for skills.

## Installation

To build and install the plugin locally (user scope):
```bash
bash scripts/install-copilot-plugin.sh
```

This installs:
- Prompts into `{VSCODE_USER_DIR}/prompts/`
- Skills into `~/.copilot/skills/`
