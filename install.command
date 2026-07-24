#!/bin/bash
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
HS_DIR="$HOME/.hammerspoon"
INIT="$HS_DIR/init.lua"
MODULE="$HS_DIR/iast.lua"
LEGACY_MODULE="$HS_DIR/visual_iast_cycle.lua"

show_message() {
  /usr/bin/osascript -e "display dialog \"$1\" buttons {\"OK\"} default button \"OK\" with title \"macOS-IAST\"" >/dev/null
}

install_hammerspoon() {
  local release_json
  local download_url
  local expected_sha
  local actual_sha
  local temp_dir
  local archive
  local extracted_app
  local bundle_id
  local app_dir
  local target_app
  local staged_app

  show_message "Hammerspoon is also needed. macOS IAST will now download the latest official version and install it for you."

  if ! release_json=$(/usr/bin/curl -fsSL \
      --connect-timeout 15 \
      --max-time 60 \
      "https://api.github.com/repos/Hammerspoon/hammerspoon/releases/latest"); then
    open "https://www.hammerspoon.org/"
    show_message "The Hammerspoon download could not be started. Check your internet connection and run this installer again."
    exit 1
  fi

  download_url=$(printf '%s\n' "$release_json" \
    | /usr/bin/sed -n 's/.*"browser_download_url": "\(https:\/\/github.com\/Hammerspoon\/hammerspoon\/releases\/download\/[^"]*\/Hammerspoon-[^"]*\.zip\)".*/\1/p' \
    | /usr/bin/head -n 1)
  expected_sha=$(printf '%s\n' "$release_json" \
    | /usr/bin/sed -n 's/.*"digest": "sha256:\([0-9a-fA-F]*\)".*/\1/p' \
    | /usr/bin/head -n 1)

  if [ -z "$download_url" ] || [ "${#expected_sha}" -ne 64 ]; then
    show_message "The latest Hammerspoon download could not be found. Please try again later."
    exit 1
  fi

  temp_dir=$(/usr/bin/mktemp -d "${TMPDIR:-/tmp}/visual-iast.XXXXXX")
  archive="$temp_dir/Hammerspoon.zip"

  if ! /usr/bin/curl -fL \
      --retry 2 \
      --connect-timeout 15 \
      --max-time 300 \
      --output "$archive" \
      "$download_url"; then
    /bin/rm -rf "$temp_dir"
    show_message "Hammerspoon could not be downloaded. Check your internet connection and run this installer again."
    exit 1
  fi

  actual_sha=$(/usr/bin/shasum -a 256 "$archive" | /usr/bin/awk '{print $1}')
  if [ "$actual_sha" != "$expected_sha" ]; then
    /bin/rm -rf "$temp_dir"
    show_message "The Hammerspoon download did not pass its safety check, so it was not installed."
    exit 1
  fi

  if ! /usr/bin/ditto -x -k "$archive" "$temp_dir/unpacked"; then
    /bin/rm -rf "$temp_dir"
    show_message "The Hammerspoon download could not be opened. Please run this installer again."
    exit 1
  fi

  extracted_app="$temp_dir/unpacked/Hammerspoon.app"
  bundle_id=$(/usr/libexec/PlistBuddy \
    -c "Print :CFBundleIdentifier" \
    "$extracted_app/Contents/Info.plist" 2>/dev/null || true)
  if [ ! -x "$extracted_app/Contents/MacOS/Hammerspoon" ] \
      || [ "$bundle_id" != "org.hammerspoon.Hammerspoon" ]; then
    /bin/rm -rf "$temp_dir"
    show_message "The Hammerspoon download did not contain the expected app, so it was not installed."
    exit 1
  fi

  if [ -w "/Applications" ]; then
    app_dir="/Applications"
  else
    app_dir="$HOME/Applications"
    /bin/mkdir -p "$app_dir"
  fi

  target_app="$app_dir/Hammerspoon.app"
  staged_app="$app_dir/.Hammerspoon.app.installing.$$"

  if ! /usr/bin/ditto "$extracted_app" "$staged_app" \
      || ! /bin/mv "$staged_app" "$target_app"; then
    /bin/rm -rf "$staged_app" "$temp_dir"
    show_message "Hammerspoon could not be copied to your Applications folder."
    exit 1
  fi

  /bin/rm -rf "$temp_dir"
}

if [ ! -d "/Applications/Hammerspoon.app" ] && [ ! -d "$HOME/Applications/Hammerspoon.app" ]; then
  install_hammerspoon
fi

mkdir -p "$HS_DIR"

if [ -f "$INIT" ]; then
  cp "$INIT" "$INIT.backup-$(date +%Y%m%d-%H%M%S)"
else
  touch "$INIT"
fi

cp "$HERE/iast.lua" "$MODULE"
/bin/rm -f "$LEGACY_MODULE"

CLEANED_INIT=$(/usr/bin/mktemp "$HS_DIR/init.lua.XXXXXX")
/usr/bin/sed \
  -e '/^-- BEGIN Visual IAST Cycle$/,/^-- END Visual IAST Cycle$/d' \
  -e '/^-- BEGIN macOS-IAST$/,/^-- END macOS-IAST$/d' \
  "$INIT" > "$CLEANED_INIT"

/bin/cat >> "$CLEANED_INIT" <<'EOF'
-- BEGIN macOS-IAST
require("iast")
-- END macOS-IAST
EOF

/bin/cp "$CLEANED_INIT" "$INIT"
/bin/rm -f "$CLEANED_INIT"

/usr/bin/osascript -e 'tell application "Hammerspoon" to quit' >/dev/null 2>&1 || true
sleep 1
if [ -d "/Applications/Hammerspoon.app" ]; then
  open "/Applications/Hammerspoon.app"
else
  open "$HOME/Applications/Hammerspoon.app"
fi
open "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility" >/dev/null 2>&1 || true

show_message "Installed. If macOS asks, enable Hammerspoon under Privacy & Security → Accessibility, then choose Reload Config from the Hammerspoon menu."
