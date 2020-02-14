Func waitForAds($timeout)
	If $GameState == $VIEWING_AD Then
		Local $isMainScreen = False
		Local $time = 0
		
		WinActivate($Title,"")
		WinWaitActive($Title,"", 2)

		While ($isMainScreen == False And $time <= $timeout)
			
			ResetStartTime()

			ControlSend($Title, "", "", "{ESC}")

			Sleep(200)

			cr("Checking ads is watched...")

			Local $mainScreen = _WaitForImageSearch($IMG_MAIN_SCREEN, 10, 1)

			If IsArray($mainScreen) Then
				cr("Ads is watched")

				$isMainScreen = True
			EndIf

			Sleep(200)
			
			$time = $time + 10
		WEnd
	EndIf
EndFunc   ;==>waitForAds
