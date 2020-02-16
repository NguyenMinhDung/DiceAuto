Func OpenGiftCard()
	Local $NoCard = False
	While (Not $NoCard)
		OpenCardStepByPos(404, 184, 200)
		OpenCardStepByPos(286, 743, 200)
		OpenCardStepByPos(268, 497, 1000)
		OpenCardStepByPos(273, 743, 100)
		OpenCardStepByPos(273, 786, 100)

		$NoCard = ClickOnImage("Images\emptycard.png", 1, $HWnD)

		If $NoCard Then
			cr("Not enough cards!")
		EndIf
	WEnd
EndFunc

Func OpenCardStepByPos($x, $y, $delay)
	Click($hwnd, $x, $y)

	Sleep($delay)
EndFunc