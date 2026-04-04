#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode("Input")
SetWorkingDir(A_ScriptDir)
SetControlDelay(-1)
SetMouseDelay(-1)
SetDefaultMouseSpeed(0)
KeyHistory(0)
SetWinDelay(-1)
A_MaxHotkeysPerInterval := 99000000
A_HotkeyInterval := 99000000

global doubleActive := true
global doubleRunning := false
global doubleTrigger := "r"
global doubleKey1 := "e"
global doubleKey2 := "Tab"
global doubleDelay := 3000
global doubleSprint := false
global doubleSprintKey := "9"

MicroDelay(microseconds) {
    DllCall("QueryPerformanceFrequency", "Int64*", &freq := 0)
    DllCall("QueryPerformanceCounter", "Int64*", &start := 0)
    target := start + (microseconds * freq / 1000000)
    loop {
        DllCall("QueryPerformanceCounter", "Int64*", &current := 0)
        if (current >= target)
            break
    }
}

DoublePollKey() {
    global doubleTrigger, doubleKey1, doubleKey2, doubleDelay
    global doubleSprint, doubleSprintKey, doubleRunning, doubleActive
    
    if (GetKeyState(doubleTrigger, "P")) {
        if (!doubleRunning) {
            doubleRunning := true
            if (doubleSprint && doubleSprintKey != "")
                Send("{" . doubleSprintKey . " down}")
            while (GetKeyState(doubleTrigger, "P") && doubleRunning) {
                Send("{" . doubleKey1 . " down}")
                MicroDelay(2000)
                Send("{" . doubleKey1 . " up}")
                if (doubleDelay > 0)
                    MicroDelay(doubleDelay)
                else
                    MicroDelay(3000)
                if (!GetKeyState(doubleTrigger, "P"))
                    break
                Send("{" . doubleKey2 . " down}")
                MicroDelay(2000)
                Send("{" . doubleKey2 . " up}")
                if (doubleDelay > 0)
                    MicroDelay(doubleDelay)
                else
                    MicroDelay(3000)
                if (!GetKeyState(doubleTrigger, "P"))
                    break
            }
            Send("{" . doubleKey1 . " up}{" . doubleKey2 . " up}")
            if (doubleSprint && doubleSprintKey != "")
                Send("{" . doubleSprintKey . " up}")
            doubleRunning := false
        }
    } else {
        if (doubleRunning) {
            Send("{" . doubleKey1 . " up}{" . doubleKey2 . " up}")
            if (doubleSprint && doubleSprintKey != "")
                Send("{" . doubleSprintKey . " up}")
            doubleRunning := false
        }
    }
}

SetTimer(DoublePollKey, 5)