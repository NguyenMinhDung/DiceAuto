Func checkMainScreen()
    Local $result = _WaitForImageSearch($IMG_MAIN_SCREEN, 3, 1)
    
    If IsArray($result) Then
        cr("Screen: Main")

        ResetStartTime()

        $GameState = $MAIN_SCREEN
	EndIf
EndFunc