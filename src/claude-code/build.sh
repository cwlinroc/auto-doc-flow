#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UNIVERSAL="$SCRIPT_DIR/../universal"
DIST="$SCRIPT_DIR/dist"

# Emit YAML frontmatter from a JSON file.
# JSON strings are valid YAML double-quoted scalars, so @json is safe for
# values containing colons, em-dashes, and other YAML-special characters.
emit_frontmatter() {
  echo "---"
  jq -r 'del(.custom_notes) | to_entries[] | "\(.key): \(.value | @json)"' "$1"
  echo "---"
}

echo "Building Claude Code plugin into $DIST ..."

rm -rf "$DIST"
mkdir -p "$DIST/.claude-plugin" "$DIST/commands"

# Plugin metadata
cp "$SCRIPT_DIR/plugin/plugin.json"      "$DIST/.claude-plugin/plugin.json"
cp "$SCRIPT_DIR/plugin/marketplace.json" "$DIST/.claude-plugin/marketplace.json"

# Commands
for json in "$SCRIPT_DIR/commands"/*.json; do
  name="$(basename "$json" .json)"
  body="$UNIVERSAL/commands/$name.md"
  if [[ ! -f "$body" ]]; then
    echo "ERROR: universal body not found for command '$name' (expected $body)" >&2
    exit 1
  fi
  out="$DIST/commands/$name.md"
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

  echo "  commands/$name.md"
done

# Skills
for json in "$SCRIPT_DIR/skills"/*.json; do
  name="$(basename "$json" .json)"
  body="$UNIVERSAL/skills/$name/SKILL.md"
  if [[ ! -f "$body" ]]; then
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
    [[ "$(basename "$helper")" == "SKILL.md" ]] && continue
    cp "$helper" "$DIST/skills/$name/"
    echo "  skills/$name/$(basename "$helper")"
  done
done

echo ""
echo "Done. Run 'claude plugin validate $DIST' to confirm."
