#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$SCRIPT_DIR/src/universal"

echo "Registering auto-doc-flow marketplace from $PLUGIN_DIR ..."
claude plugin marketplace add "$PLUGIN_DIR"

echo "Installing auto-doc-flow plugin (user scope)..."
claude plugin install adf@auto-doc-flow --scope user

echo ""
echo "Done. Invoke skills and commands with the /auto-doc-flow: prefix, e.g.:"
echo "  /auto-doc-flow:grill-with-doc"
echo "  /auto-doc-flow:brain-storm-with-doc"
