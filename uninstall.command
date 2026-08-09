#!/bin/bash
set -euo pipefail

HS_DIR="$HOME/.hammerspoon"
INIT="$HS_DIR/init.lua"
MODULE="$HS_DIR/iast.lua"
LEGACY_MODULE="$HS_DIR/visual_iast_cycle.lua"

if [ -f "$INIT" ]; then
  cp "$INIT" "$INIT.backup-$(date +%Y%m%d-%H%M%S)"
  CLEANED_INIT=$(/usr/bin/mktemp "$HS_DIR/init.lua.XXXXXX")
  /usr/bin/sed \
    -e '/^-- BEGIN Visual IAST Cycle$/,/^-- END Visual IAST Cycle$/d' \
    -e '/^-- BEGIN macOS-IAST$/,/^-- END macOS-IAST$/d' \
    -e '/^-- BEGIN iastype$/,/^-- END iastype$/d' \
    -e '/^-- BEGIN IASType$/,/^-- END IASType$/d' \
    "$INIT" > "$CLEANED_INIT"
  /bin/cp "$CLEANED_INIT" "$INIT"
  /bin/rm -f "$CLEANED_INIT"
fi
/bin/rm -f "$MODULE" "$LEGACY_MODULE"
/usr/bin/osascript -e 'tell application "Hammerspoon" to quit' >/dev/null 2>&1 || true
sleep 1
open -a Hammerspoon >/dev/null 2>&1 || true
/usr/bin/osascript -e 'display dialog "IASType was removed. Hammerspoon itself was left installed because you may use it for other automations." buttons {"OK"} default button "OK" with title "IASType"' >/dev/null
