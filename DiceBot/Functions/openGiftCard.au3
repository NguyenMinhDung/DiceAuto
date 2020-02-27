Func OpenGiftCard()
	Local $NoCard = False
	While (Not $NoCard)
		OpenCardStepByPos(272, 144, 100)
		OpenCardStepByPos(189, 514, 100)
		OpenCardStepByPos(182, 353, 100)
		OpenCardStepByPos(190, 518, 100)
		OpenCardStepByPos(195, 551, 100)

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