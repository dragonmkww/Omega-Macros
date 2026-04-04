#Requires AutoHotkey v2.0
#SingleInstance Force
InstallKeybdHook
SendMode("Input")
SetKeyDelay(0, 0)

EditBind := "e"
DragHoldKey := "Tab"
ScrollDirection := "WheelDown"
DragDelay := 12
IsExecuting := false

HotKey("$" . EditBind, ExecuteDragMacro)

ExecuteDragMacro(*) {
    global IsExecuting, EditBind, DragHoldKey, ScrollDirection, DragDelay
    if (IsExecuting)
        return
    IsExecuting := true
    
    Send("{" . ScrollDirection . "}")
    
    if (DragDelay > 0)
        Sleep(DragDelay)
    
    Send("{" . DragHoldKey . " down}")
    
    While GetKeyState(EditBind, "P") {
        Sleep(10)
    }
    
    Send("{" . DragHoldKey . " up}")
    
    Send("{" . EditBind . "}")
    
    IsExecuting := false
}
