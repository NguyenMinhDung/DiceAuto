Func CapturePosition()
	cr("Update position slot " & $slot)

	Local $mousePos = MouseGetPos()

	$mousePos = ScreenToClient($mousePos[0], $mousePos[1], $HWnD)

	If $slot == 1 Then
		$slot1 = $mousePos
		$slot = 2
		cr("Slot 1: " & $slot1[0] & "," & $slot1[1])
	ElseIf $slot == 2 Then
		$slot2 = $mousePos
		$slot = 3
		cr("Slot 2: " & $slot2[0] & "," & $slot2[1])
	ElseIf $slot == 3 Then
		$slot3 = $mousePos
		$slot = 4
		cr("Slot 3: " & $slot3[0] & "," & $slot3[1])
	ElseIf $slot == 4 Then
		$slot4 = $mousePos
		$slot = 5
		cr("Slot 4: " & $slot4[0] & "," & $slot4[1])
	Else
		$slot5 = $mousePos
		$slot = 1
		cr("Slot 5: " & $slot5[0] & "," & $slot5[1])
	EndIf

EndFunc   ;==>CapturePosition