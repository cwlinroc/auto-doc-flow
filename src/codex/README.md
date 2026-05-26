# Codex CLI Packaging for ADF

This directory contains the settings and build script to package Auto Doc Flow skills and commands for the OpenAI Codex CLI agent.

## Layout

- `commands/` - JSON configuration files for universal commands (built as skills).
- `skills/` - JSON configuration files for universal skills.
- `plugin.json` - Metadata description.
- `build.sh` - Assembles the skills from `src/universal/` and outputs them into `dist/`.

## Build

To compile the Codex skills:
```bash
bash src/codex/build.sh
```

This creates the `dist/skills/` directory containing all configured skills.

## Installation

To build and install the plugin locally to your global `~/.codex/skills/` directory:
```bash
bash scripts/install-codex-plugin.sh
```
