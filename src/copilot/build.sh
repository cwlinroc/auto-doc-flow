#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UNIVERSAL="$SCRIPT_DIR/../universal"
DIST="$SCRIPT_DIR/dist"

# Emit YAML frontmatter from a JSON file.
emit_frontmatter() {
  echo "---"
  jq -r 'del(.custom_notes) | to_entries[] | "\(.key): \(.value | @json)"' "$1"
  echo "---"
}

echo "Building Copilot plugin into $DIST ..."

rm -rf "$DIST"
mkdir -p "$DIST/prompts" "$DIST/skills"

# Plugin metadata
cp "$SCRIPT_DIR/plugin.json" "$DIST/plugin.json"

# Commands (packaged as prompts for Copilot)
if [ -d "$SCRIPT_DIR/commands" ]; then
  for json in "$SCRIPT_DIR/commands"/*.json; do
    [ -e "$json" ] || continue
    name="$(basename "$json" .json)"
    body="$UNIVERSAL/commands/$name.md"
    if [ ! -f "$body" ]; then
      echo "ERROR: universal body not found for command '$name' (expected $body)" >&2
      exit 1
    fi
    out="$DIST/prompts/$name.prompt.md"
    { emit_frontmatter "$json"; echo ""; cat "$body"; } > "$out"

    # Append custom notes if present
    notes=$(jq -r '.custom_notes | select(. != null) | .[] | "- \(.)"' "$json")
    if [ -n "$notes" ]; then
      {
        echo ""
        echo "## Custom Notes"
        echo ""
        echo "$notes"
      } >> "$out"
    fi

    echo "  prompts/$name.prompt.md"
  done
fi

# Skills
if [ -d "$SCRIPT_DIR/skills" ]; then
  for json in "$SCRIPT_DIR/skills"/*.json; do
    [ -e "$json" ] || continue
    name="$(basename "$json" .json)"
    body="$UNIVERSAL/skills/$name/SKILL.md"
    if [ ! -f "$body" ]; then
      echo "ERROR: universal body not found for skill '$name' (expected $body)" >&2
      exit 1
    fi
    mkdir -p "$DIST/skills/$name"
    out="$DIST/skills/$name/SKILL.md"
    { emit_frontmatter "$json"; echo ""; cat "$body"; } > "$out"

    # Append custom notes if present
    notes=$(jq -r '.custom_notes | select(. != null) | .[] | "- \(.)"' "$json")
    if [ -n "$notes" ]; then
      {
        echo ""
        echo "## Custom Notes"
        echo ""
        echo "$notes"
      } >> "$out"
    fi

    echo "  skills/$name/SKILL.md"

    # Copy sibling helper files (e.g. ADR-FORMAT.md) verbatim
    for helper in "$UNIVERSAL/skills/$name"/*; do
      [ -e "$helper" ] || continue
      [ "$(basename "$helper")" = "SKILL.md" ] && continue
      cp "$helper" "$DIST/skills/$name/"
      echo "  skills/$name/$(basename "$helper")"
    done
  done
fi

echo ""
echo "Done. Copilot plugin built successfully."
