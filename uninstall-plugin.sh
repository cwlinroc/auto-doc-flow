#!/usr/bin/env bash
set -euo pipefail

echo "Removing auto-doc-flow marketplace and plugin..."
claude plugin marketplace remove auto-doc-flow

echo "Done. Plugin and marketplace registration removed."
