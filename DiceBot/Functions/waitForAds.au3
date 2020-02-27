Func waitForAds($timeout)
	If $GameState == $VIEWING_AD Then
		Local $isMainScreen = False
		Local $time = 0
		Local $count = 0

		WinActivate($Title)
		WinWaitActive($Title, "", 5)

		While ($isMainScreen == False)

			If $time > $timeout Then
				$GameState = $RESTART
				$AppRestart = True

				RestartApk("com.percent.royaldice")
				
				ExitLoop
			EndIf
			
			ResetStartTime()

			ControlSend($Title, "", "", "{ESC}")

			Sleep(200)

			If $count >= 4 Then
				cr("Close ads")

				ClickOnImage("Images\close.png", 5, $HWnD)
			Else
				cr("Resume ads " & $count)

				Local $result = ClickOnImage("Images\resume.png", 5, $HWnD)

				If $result Then
					$count = $count + 1
				EndIf
			EndIf

			cr("Checking ads is watched...")

			Sleep(200)

			Local $mainScreen = _WaitForImageSearch($IMG_MAIN_SCREEN, 5, 1)

			If IsArray($mainScreen) Then
				cr("Ads is watched")

				$isMainScreen = True
			EndIf

			Sleep(200)
			
			$time = $time + 10
		WEnd
	EndIf
EndFunc   ;==>waitForAds
