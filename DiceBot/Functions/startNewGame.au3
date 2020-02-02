Func startNewGame()
	If $GameState == $MAIN_SCREEN Then
		Local $result = enterAlliMode()

		If $result Then
			$GameState = $ALLI_MODE_POPUP
		EndIf
	EndIf
EndFunc   ;==>startNewGame

Func enterAlliMode()
	cr("Press start new game...")

	Local $result = ClickOnImage($IMG_PVE, 5, $HWnD)

	If Not $result Then
		Return False
	EndIf

	Return True
EndFunc   ;==>enterAlliMode
