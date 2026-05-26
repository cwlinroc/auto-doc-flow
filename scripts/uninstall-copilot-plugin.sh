#!/usr/bin/env bash
set -euo pipefail

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

echo -e "\033[0;36mUninstalling auto-doc-flow from GitHub Copilot...\033[0m"

ADF_PROMPTS=(
  "brain-storm-with-doc.prompt.md"
  "grill-with-doc.prompt.md"
  "review-with-doc.prompt.md"
  "sync-with-doc.prompt.md"
  "trouble-shoot-with-doc.prompt.md"
)

ADF_SKILLS=(
  "docs-structure"
  "project-docs-structure"
)

# Uninstall Prompts
echo -e "\n\033[0;36mRemoving prompts from $PROMPTS_DEST ...\033[0m"
if [ -d "$PROMPTS_DEST" ]; then
  removed_any=false
  for prompt in "${ADF_PROMPTS[@]}"; do
    prompt_path="$PROMPTS_DEST/$prompt"
    if [ -f "$prompt_path" ]; then
      rm -f "$prompt_path"
      echo "  Removed prompt: $prompt"
      removed_any=true
    fi
  done
  if [ "$removed_any" = false ]; then
    echo "  No ADF prompts found."
  fi
else
  echo "  VS Code prompts directory not found."
fi

# Uninstall Skills
echo -e "\n\033[0;36mRemoving skills from $SKILLS_DEST ...\033[0m"
if [ -d "$SKILLS_DEST" ]; then
  removed_any=false
  for skill in "${ADF_SKILLS[@]}"; do
    skill_path="$SKILLS_DEST/$skill"
    if [ -d "$skill_path" ]; then
      rm -rf "$skill_path"
      echo "  Removed skill: $skill"
      removed_any=true
    fi
  done
  if [ "$removed_any" = false ]; then
    echo "  No ADF skills found."
  fi
else
  echo "  Copilot skills directory not found."
fi

echo -e "\n\033[0;36mDone. ADF plugin successfully uninstalled from GitHub Copilot.\033[0m"
