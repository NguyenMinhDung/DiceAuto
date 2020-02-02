Func checkQuickMatch()
    Sleep(1000)

    If $GameState == 0 Or $GameState == $ALLI_MODE_POPUP Then
        cr("Checking quick match popup...")
        Local $result = ClickOnImage($IMG_QUICK_MATCH, 4, $HWnD)

        If $result Then
            $GameState = $GAME_STARTED
            cr("Starting game...")
        Else
            $GameState = 0
        EndIf
    EndIf
EndFunc

Func Test()
    Local $hWin = WinGetHandle($Title)
    Local $mousePos = MouseGetPos()
    $mousePos = ScreenToClient($mousePos[0], $mousePos[1], $hWin)

    cr("#" & WinGetPixelColor($mousePos[0], $mousePos[1], $hWin))
EndFunc