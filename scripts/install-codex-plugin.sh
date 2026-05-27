#!/usr/bin/env bash
set -euo pipefail

# Get the directory of the script and go up one level to the project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

DIST_DIR="$PROJECT_ROOT/src/codex/dist"

# Convert backslashes to forward slashes in USERPROFILE if any, fallback to HOME
USER_HOME="${USERPROFILE:-$HOME}"
USER_HOME="${USER_HOME//\\//}"
TARGET_DIR="${USER_HOME}/.codex/skills"

echo -e "\033[0;36mBuilding Codex plugin ...\033[0m"
bash "$PROJECT_ROOT/src/codex/build.sh"

echo -e "\n\033[0;36mInstalling to $TARGET_DIR ...\033[0m"
mkdir -p "$TARGET_DIR"

# Clean up deprecated global skill
if [ -d "$TARGET_DIR/project-docs-structure" ]; then
  rm -rf "$TARGET_DIR/project-docs-structure"
  echo "  Cleaned up deprecated global skill: project-docs-structure"
fi

# Copy each skill directory from dist/skills to ~/.codex/skills
if [ -d "$DIST_DIR/skills" ]; then
  for skill_dir in "$DIST_DIR/skills"/*; do
    [ -d "$skill_dir" ] || continue
    skill_name="$(basename "$skill_dir")"
    dest_skill_dir="$TARGET_DIR/$skill_name"
    if [ -d "$dest_skill_dir" ]; then
      rm -rf "$dest_skill_dir"
    fi
    cp -r "$skill_dir" "$TARGET_DIR/"
    echo "  Installed skill: $skill_name"
  done
fi

echo -e "\n\033[0;36mDone. ADF plugin successfully installed in Codex CLI.\033[0m"
