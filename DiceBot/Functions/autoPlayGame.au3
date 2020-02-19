HotKeySet("{F1}", "CapturePosition")
HotKeySet("{F2}", "OpenGiftCard")
HotKeySet("{F3}", "GetColorFromMouse")


Func autoPlayGame()
	If $GameState == $BATTLE_SCREEN Then
		cr("Adding new dice (x=" & $NewDicePos[0] & ",y=" & $NewDicePos[1] & ")")

		ResetStartTime()

		Click($Title, $NewDicePos[0], $NewDicePos[1], 4, 500)

		$NewDiceCount = $NewDiceCount + 1

		If $NewDiceCount > 5 Then
			UpgradeDice()
		EndIf

		AutoMerge()
	EndIf
EndFunc   ;==>autoPlayGame

Func AutoMerge()
	cr("Pending: " & $PendingMerge)
	cr("LimitForMerge: " & $LimitForMerge)

	If $PendingMerge >= $LimitForMerge Then
		Local $NumCellEmpty = ScanDice()

		FindPair()

		If $NumCellEmpty <= 2 Or $Pair[0][3] == 1 Then
			;~ For $i = 0 To 5
			;~ 	ConsoleWrite($DiceMatrix[$Pair[0][0]][$i] & " | ")
			;~ Next

			;~ cr()
	
			;~ For $i = 0 To 5
			;~ 	ConsoleWrite($DiceMatrix[$Pair[0][1]][$i] & " | ")
			;~ Next

			;~ cr()

			$PendingMerge = 0
			$LimitForMerge = $LimitForMerge + 1


			MergeDice($Pair[0][0], $Pair[0][1])
		EndIf
	Else
		$PendingMerge = $PendingMerge + 3
	EndIf
EndFunc

Func UpgradeDice()
	cr("Upgrate slot " & $curUpgradeDice)

	If $curUpgradeDice == 1 And IsArray($slot1) Then
		Click($Title, $slot1[0], $slot1[1])

	ElseIf $curUpgradeDice == 2 And IsArray($slot2) Then
		Click($Title, $slot2[0], $slot2[1])

	ElseIf $curUpgradeDice == 3 And IsArray($slot3) Then
		Click($Title, $slot3[0], $slot3[1])

	ElseIf $curUpgradeDice == 4 And IsArray($slot4) Then
		Click($Title, $slot4[0], $slot4[1])

	ElseIf IsArray($slot5) Then

		Click($Title, $slot5[0], $slot5[1])
	EndIf

	$curUpgradeDice = $curUpgradeDice + 1

	If $curUpgradeDice > 5 Then
		$curUpgradeDice = 1
	EndIf
EndFunc   ;==>UpgradeDice

Func DetectColor()
	
	cr(WinGetPixelColor(149,557, $HWnD))
	cr(WinGetPixelColor(438,236, $HWnD))
	cr(WinGetPixelColor(97,616, $HWnD))
	cr(WinGetPixelColor(278,615, $HWnD))
	cr(WinGetPixelColor(457,615, $HWnD))
EndFunc

Func CustomMouseMove()
	Local $mousePos = MouseGetPos()
	cr("Slot 1: " & $mousePos[0] & "," & $mousePos[1])

	;MouseClickDrag("left", 1519,619, 1712,621)
	;ControlMouseDrag($HWnD, 150,558, 150,621)
EndFunc

Func GetColorFromMouse()

	HidePointer(True)

	CaptureRegion()

	Local $mousePos = MouseGetPos()

	cr("mousePos: " & $mousePos[0] & "," & $mousePos[1])

	$mousePos = ScreenToClient($mousePos[0], $mousePos[1], $HWnD)

	ConsoleWrite(GetPixelColor($mousePos[0], $mousePos[1], $HBitmap) & @CRLF)

	HidePointer(False)
EndFunc

Func ControlMouseDrag($hWindow, $x1, $y1, $x2, $y2)
    _SendMessage($hWindow, $WM_MOUSEMOVE,   0, _WinAPI_MakeLong($x1, $y1))
    _SendMessage($hWindow, $WM_LBUTTONDOWN, 1, _WinAPI_MakeLong($x1, $y1))
    _SendMessage($hWindow, $WM_MOUSEMOVE,   1, _WinAPI_MakeLong($x2, $y2))
    _SendMessage($hWindow, $WM_LBUTTONUP,   0, _WinAPI_MakeLong($x2, $y2))
EndFunc