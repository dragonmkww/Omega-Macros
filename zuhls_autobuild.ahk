#Requires AutoHotkey v2.0
#SingleInstance Force
InstallKeybdHook
SendMode("Input")
SetKeyDelay(0, 0)

AutoBuildTrigger := "p"
AutoBuildHold := "Backspace"
AutoBuildToggleState := false

HotKey("$*" . AutoBuildTrigger, ToggleAutoBuild)

ToggleAutoBuild(*) {
    global AutoBuildToggleState, AutoBuildHold
    AutoBuildToggleState := !AutoBuildToggleState
    if (AutoBuildToggleState) {
        Send("{" . AutoBuildHold . " down}")
    } else {
        Send("{" . AutoBuildHold . " up}")
    }
}
