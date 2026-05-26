#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_SCRIPT="$SCRIPT_DIR/src/claude-code/build.sh"
PLUGIN_DIR="$SCRIPT_DIR/src/claude-code/dist"

echo "Building plugin ..."
bash "$BUILD_SCRIPT"

echo ""
echo "Registering auto-doc-flow marketplace from $PLUGIN_DIR ..."
claude plugin marketplace add "$PLUGIN_DIR"

echo "Installing auto-doc-flow plugin (user scope)..."
claude plugin install adf@auto-doc-flow --scope user

echo ""
echo "Done. Invoke skills and commands with the /adf: prefix, e.g.:"
echo "  /adf:grill-with-doc"
echo "  /adf:brain-storm-with-doc"
