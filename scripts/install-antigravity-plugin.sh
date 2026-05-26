#!/usr/bin/env bash
set -euo pipefail

# Get the directory of the script and go up one level to the project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

DIST_DIR="$PROJECT_ROOT/src/antigravity/dist"

# Convert backslashes to forward slashes in USERPROFILE if any, fallback to HOME
USER_HOME="${USERPROFILE:-$HOME}"
USER_HOME="${USER_HOME//\\//}"
TARGET_DIR="${USER_HOME}/.gemini/config/plugins/adf-plugin"

echo -e "\033[0;36mBuilding Antigravity plugin ...\033[0m"
bash "$PROJECT_ROOT/src/antigravity/build.sh"

echo -e "\n\033[0;36mInstalling to $TARGET_DIR ...\033[0m"
if [ -d "$TARGET_DIR" ]; then
    rm -rf "$TARGET_DIR"
fi
mkdir -p "$TARGET_DIR"

cp -r "$DIST_DIR"/* "$TARGET_DIR"/

echo -e "\n\033[0;36mDone. ADF plugin successfully installed in Antigravity.\033[0m"
echo -e "\033[0;90mPlease restart or reload Antigravity to activate the plugin.\033[0m"
