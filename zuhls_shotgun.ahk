#Requires AutoHotkey v2.0
#SingleInstance Force
InstallKeybdHook
SendMode("Input")
SetKeyDelay(0, 0)

ShotgunKey := "3"
HotKey("~LButton", ShotgunPullout)

ShotgunPullout(*) {
    global ShotgunKey
    KeyWait("LButton")
    Sleep(1)
    Send("{" . ShotgunKey . "}")
}
