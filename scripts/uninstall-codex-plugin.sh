#!/usr/bin/env bash
set -euo pipefail

# Convert backslashes to forward slashes in USERPROFILE if any, fallback to HOME
USER_HOME="${USERPROFILE:-$HOME}"
USER_HOME="${USER_HOME//\\//}"
TARGET_DIR="${USER_HOME}/.codex/skills"

echo -e "\033[0;36mUninstalling auto-doc-flow skills from Codex CLI...\033[0m"

ADF_SKILLS=(
  "brain-storm-with-doc"
  "grill-with-doc"
  "organize-doc"
  "review-with-doc"
  "sync-with-doc"
  "trouble-shoot-with-doc"
  "docs-structure"
  "project-docs-structure"
)

if [ -d "$TARGET_DIR" ]; then
  removed_any=false
  for skill in "${ADF_SKILLS[@]}"; do
    skill_path="$TARGET_DIR/$skill"
    if [ -d "$skill_path" ]; then
      rm -rf "$skill_path"
      echo "  Removed skill: $skill"
      removed_any=true
    fi
  done
  if [ "$removed_any" = true ]; then
    echo -e "\n\033[0;36mDone. ADF skills successfully uninstalled from Codex CLI.\033[0m"
  else
    echo -e "\n\033[0;33mNo ADF skills found in Codex directory. Nothing to uninstall.\033[0m"
  fi
else
  echo -e "\n\033[0;33mCodex skills directory not found. Nothing to uninstall.\033[0m"
fi
