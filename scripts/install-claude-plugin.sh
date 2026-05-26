#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
BUILD_SCRIPT="$PROJECT_ROOT/src/claude-code/build.sh"
PLUGIN_DIR="$PROJECT_ROOT/src/claude-code/dist"

echo -e "\033[0;36mBuilding auto-doc-flow Claude Code plugin...\033[0m"
bash "$BUILD_SCRIPT"

echo ""
echo "Registering auto-doc-flow marketplace from $PLUGIN_DIR ..."
claude plugin marketplace add "$PLUGIN_DIR"

echo "Installing auto-doc-flow plugin (user scope)..."
claude plugin install adf@auto-doc-flow --scope user

echo ""
echo -e "\033[0;36mDone. Invoke skills and commands with the /adf: prefix, e.g.:\033[0m"
echo "  /adf:grill-with-doc"
echo "  /adf:brain-storm-with-doc"
