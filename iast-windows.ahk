#Requires AutoHotkey v2.0
#SingleInstance Force
#InstallKeybdHook
#UseHook

; IASType + ISO 15919 typing for Windows.
; Hold Alt and tap a supported letter. Tap that letter again while Alt is
; still held to cycle through its related forms.

global mappings := Map(
    "a", Map("lower", ["ā"],             "upper", ["Ā"]),
    "i", Map("lower", ["ī"],             "upper", ["Ī"]),
    "u", Map("lower", ["ū"],             "upper", ["Ū"]),
    "e", Map("lower", ["ē"],             "upper", ["Ē"]),
    "o", Map("lower", ["ō"],             "upper", ["Ō"]),
    "r", Map("lower", ["ṛ", "ṝ", "ṟ"], "upper", ["Ṛ", "Ṝ", "Ṟ"]),
    "l", Map("lower", ["ḷ", "ḻ", "ḹ"], "upper", ["Ḷ", "Ḻ", "Ḹ"]),
    "s", Map("lower", ["ś", "ṣ"],       "upper", ["Ś", "Ṣ"]),
    "n", Map("lower", ["ṇ", "ñ", "ṅ"], "upper", ["Ṇ", "Ñ", "Ṅ"]),
    "m", Map("lower", ["ṁ", "ṃ"],       "upper", ["Ṁ", "Ṃ"]),
    "t", Map("lower", ["ṭ"],             "upper", ["Ṭ"]),
    "d", Map("lower", ["ḍ"],             "upper", ["Ḍ"]),
    "h", Map("lower", ["ḥ"],             "upper", ["Ḥ"])
)

global lastKey := ""
global lastUpper := false
global cycleIndex := 0
global stopFile := A_ScriptDir "\IASType.stop"

; Hotkeys without * require Alt and do not claim Ctrl+Alt combinations. This
; leaves Ctrl+Alt shortcuts and AltGr available to Windows and applications.
$!a::HandleIAST("a", false)
$!+a::HandleIAST("a", true)
$!i::HandleIAST("i", false)
$!+i::HandleIAST("i", true)
$!u::HandleIAST("u", false)
$!+u::HandleIAST("u", true)
$!e::HandleIAST("e", false)
$!+e::HandleIAST("e", true)
$!o::HandleIAST("o", false)
$!+o::HandleIAST("o", true)
$!r::HandleIAST("r", false)
$!+r::HandleIAST("r", true)
$!l::HandleIAST("l", false)
$!+l::HandleIAST("l", true)
$!s::HandleIAST("s", false)
$!+s::HandleIAST("s", true)
$!n::HandleIAST("n", false)
$!+n::HandleIAST("n", true)
$!m::HandleIAST("m", false)
$!+m::HandleIAST("m", true)
$!t::HandleIAST("t", false)
$!+t::HandleIAST("t", true)
$!d::HandleIAST("d", false)
$!+d::HandleIAST("d", true)
$!h::HandleIAST("h", false)
$!+h::HandleIAST("h", true)

; A new Alt press, release, or mouse click starts a new cycle. The tilde
; keeps the original Windows input intact.
~LAlt Up::ResetCycle()
~RAlt Up::ResetCycle()
~LButton::ResetCycle()
~RButton::ResetCycle()
~MButton::ResetCycle()

SetTimer(CheckForStopRequest, 250)
OnExit(CleanUp)

HandleIAST(key, upper) {
    global mappings, lastKey, lastUpper, cycleIndex

    variants := mappings[key][upper ? "upper" : "lower"]
    isCycle := variants.Length > 1 && lastKey = key && lastUpper = upper

    if isCycle {
        cycleIndex := Mod(cycleIndex, variants.Length) + 1
        Send "{Backspace}"
    } else {
        cycleIndex := 1
    }

    ; SendText uses Unicode input, so this works independently of the active
    ; Windows keyboard layout and does not need a special font or code page.
    SendText variants[cycleIndex]
    lastKey := key
    lastUpper := upper
}

ResetCycle(*) {
    global lastKey, lastUpper, cycleIndex
    lastKey := ""
    lastUpper := false
    cycleIndex := 0
}

CheckForStopRequest() {
    global stopFile
    if FileExist(stopFile) {
        try FileDelete stopFile
        ExitApp
    }
}

CleanUp(*) {
    global stopFile
    try FileDelete stopFile
}
