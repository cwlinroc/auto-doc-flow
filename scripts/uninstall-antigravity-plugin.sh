#!/usr/bin/env bash
set -euo pipefail

# Convert backslashes to forward slashes in USERPROFILE if any, fallback to HOME
USER_HOME="${USERPROFILE:-$HOME}"
USER_HOME="${USER_HOME//\\//}"
TARGET_DIR="${USER_HOME}/.gemini/config/plugins/adf-plugin"

echo -e "\033[0;36mUninstalling auto-doc-flow plugin from Antigravity...\033[0m"

if [ -d "$TARGET_DIR" ]; then
    rm -rf "$TARGET_DIR"
    echo -e "\n\033[0;36mDone. ADF plugin successfully uninstalled from Antigravity.\033[0m"
else
    echo -e "\n\033[0;33mADF plugin target directory not found. Nothing to uninstall.\033[0m"
fi
