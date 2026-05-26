#!/usr/bin/env bash
set -euo pipefail

echo -e "\033[0;36mRemoving auto-doc-flow marketplace and plugin from Claude Code...\033[0m"
claude plugin marketplace remove auto-doc-flow

echo -e "\033[0;36mDone. Plugin and marketplace registration removed.\033[0m"
