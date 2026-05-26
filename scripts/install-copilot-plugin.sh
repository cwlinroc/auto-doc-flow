#!/usr/bin/env bash
set -euo pipefail

# Get the directory of the script and go up one level to the project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

DIST_DIR="$PROJECT_ROOT/src/copilot/dist"

# Detect VS Code user data directory (default profile)
if [[ "$OSTYPE" == "darwin"* ]]; then
  VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
  VSCODE_USER_DIR="${APPDATA}/Code/User"
else
  VSCODE_USER_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/Code/User"
fi

# Normalize backslashes for path safety in bash
VSCODE_USER_DIR="${VSCODE_USER_DIR//\\//}"
PROMPTS_DEST="${VSCODE_USER_DIR}/prompts"

USER_HOME="${USERPROFILE:-$HOME}"
USER_HOME="${USER_HOME//\\//}"
SKILLS_DEST="${USER_HOME}/.copilot/skills"

echo -e "\033[0;36mBuilding Copilot plugin ...\033[0m"
bash "$PROJECT_ROOT/src/copilot/build.sh"

# Install Prompts (Commands)
echo -e "\n\033[0;36mInstalling prompts to $PROMPTS_DEST ...\033[0m"
mkdir -p "$PROMPTS_DEST"

if [ -d "$DIST_DIR/prompts" ]; then
  for src in "$DIST_DIR/prompts"/*.prompt.md; do
    [ -e "$src" ] || continue
    filename="$(basename "$src")"
    cp "$src" "$PROMPTS_DEST/$filename"
    echo "  Installed prompt: $filename"
  done
fi

# Install Skills
echo -e "\n\033[0;36mInstalling skills to $SKILLS_DEST ...\033[0m"
mkdir -p "$SKILLS_DEST"

if [ -d "$DIST_DIR/skills" ]; then
  for skill_dir in "$DIST_DIR/skills"/*; do
    [ -d "$skill_dir" ] || continue
    skill_name="$(basename "$skill_dir")"
    dest_skill_dir="$SKILLS_DEST/$skill_name"
    if [ -d "$dest_skill_dir" ]; then
      rm -rf "$dest_skill_dir"
    fi
    cp -r "$skill_dir" "$SKILLS_DEST/"
    echo "  Installed skill: $skill_name"
  done
fi

echo -e "\n\033[0;36mDone. ADF plugin successfully installed in GitHub Copilot (VS Code).\033[0m"
