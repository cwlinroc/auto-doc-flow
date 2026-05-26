# Package and install skills and commands for Google Antigravity agent

**Status:** Accepted
**Date:** 20260526-1035

## Context

Following the decision in [20260526-1007-split-universal-vs-claude-code-build.md](./20260526-1007-split-universal-vs-claude-code-build.md), we decoupled the portable instruction prose in `src/universal/` from the Claude-Code-specific packaging in `src/claude-code/`.

We now want to extend support to the Google Antigravity agent (`antigravity`), enabling it to load the exact same documentation workflows (brainstorm, grill, review, sync, troubleshoot).

Antigravity loads plugins from the user's directory `C:\Users\ChunWeiLin\.gemini\config\plugins\<plugin-name>`. The loader expects:
- `plugin.json` at the root of the plugin directory for metadata.
- `skills/<skill-name>/SKILL.md` (or similar) containing the skill prose and YAML frontmatter.
- Unlike Claude Code, it has no native separate `commands/` directory mapping.

## Decision

Introduce dedicated packaging and a build pipeline for Antigravity under `src/antigravity/` and an installation script.

1. **Packaging Directory Structure (`src/antigravity/`)**:
   - **`plugin.json`**: Metadata describing the plugin (`adf-plugin`).
   - **`skills/`**: JSON configuration mapping for universal skills.
   - **`commands/`**: JSON configuration mapping for universal commands (compiled as skills).
   - **`build.sh`**: The build generator. It reads universal files and local settings, and compiles the plugin into `src/antigravity/dist/` (a gitignored build artifact, consistent with `src/claude-code/dist/` per [ADR 20260526-1007](./20260526-1007-split-universal-vs-claude-code-build.md)).
   
2. **Commands-as-Skills Mapping**:
   Since Antigravity lacks a native `commands/` directory in its plugin loader, we map both the universal skills *and* universal commands to native Antigravity skills.
   - A command named `grill-with-doc` is built as `skills/grill-with-doc/SKILL.md`.
   - The JSON settings for commands and skills will contain `name` and `description` to populate the YAML frontmatter.

3. **Install Flow (`install-antigravity-plugin.ps1`)**:
   Create a PowerShell installation script at the repository root. When run, it:
   - Builds the Antigravity plugin (calling `bash src/antigravity/build.sh`).
   - Recursively copies `src/antigravity/dist/*` to the user's local Antigravity plugin directory: `C:\Users\ChunWeiLin\.gemini\config\plugins\adf-plugin`.

## Consequences

**Positive:**
- Zero duplication of portable instruction prose: both Claude Code and Antigravity consume the exact same source files in `src/universal/`.
- Clean boundary: Antigravity-specific schemas (`plugin.json` and settings JSON files) are separated from universal prose and Claude Code assets.
- Automated installation: local developers can build and install the plugin with a single script execution.

**Negative / trade-offs:**
- Commands do not map to registered slash commands in Antigravity. Instead, they act as active guidelines/skills that the agent activates when the user requests the workflow (e.g. following the prompt instructions in `grill-with-doc/SKILL.md`).
- Developers must maintain settings JSON mappings in two target-specific directories (`src/claude-code/` and `src/antigravity/`).

## Alternatives considered

- **Shared `build.sh` at root**: A single builder script for all agents. Rejected: keeps agent concerns separate; a script under `src/antigravity/` matches `src/claude-code/build.sh`'s pattern and encapsulates agent-specific packaging cleanly.
- **Copying raw markdown directly**: Skipping the settings JSON maps for Antigravity. Rejected: lacks metadata integration and versioning; does not support YAML frontmatter compilation, which the agent uses to automatically categorize and activate skills.

---

**Correction note — 2026-05-26:** The install script named in Decision item 3 (`install-antigravity-plugin.ps1`, PowerShell, at the repository root) was replaced with a cross-platform bash script at `scripts/install-antigravity-plugin.sh`. All other installer scripts were also moved under `scripts/` (`scripts/install-claude-plugin.sh`, `scripts/uninstall-antigravity-plugin.sh`, `scripts/uninstall-claude-plugin.sh`). The architectural decision — a single script that builds then copies `dist/` to the Antigravity config directory — is unchanged.
