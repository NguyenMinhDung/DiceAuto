Opt("GUIOnEventMode", 1)

_GDIPlus_Startup()

$sBotVersion = "3.2.0"
$sBotTitle = "AutoIt DiceBot v" & $sBotVersion

AdbCommand("nox_adb.exe connect 127.0.0.1:62001")

$frmMain = GUICreate("Auto Dice v3.2.0", 194, 57, 192, 124)
GUISetOnEvent($GUI_EVENT_CLOSE, "WinExit")

$btnStart = GUICtrlCreateButton("Start", 16, 16, 75, 25)
GUICtrlSetOnEvent($btnStart, "btnStart_Click")

$btnPause = GUICtrlCreateButton("Pause", 104, 16, 75, 25)
GUICtrlSetOnEvent($btnPause, "btnPause_Click")

GUISetState(@SW_SHOW)

While 1
	Sleep(10)
	If Not $IsPause And $IsRunning Then
		gameLoop()
	EndIf
WEnd

_GDIPlus_Shutdown()

Func btnStart_Click()
	$IsRunning = True
	$IsPause = False

	GUICtrlSetState($btnStart, $GUI_DISABLE)

	GUICtrlSetData($btnPause, "Pause")
EndFunc   ;==>btnStart_Click

Func btnPause_Click()
	$IsPause = Not $IsPause

	If $IsPause Then
		cr("Pause..." & @CRLF)
		GUICtrlSetData($btnPause, "Resume")
	Else
		cr("Resume..." & @CRLF)
		GUICtrlSetData($btnPause, "Pause")
	EndIf
EndFunc   ;==>btnPause_Click

Func gameLoop()
	While Not $IsPause
		checkMainScreen()
		
		checkAds()

		viewAds()
		
		waitForAds(50)

        startNewGame()

        checkQuickMatch()

        checkBattleScreen()

		autoPlayGame()
		
		checkDisconnect()

		checkTimeout(90)
	WEnd
EndFunc   ;==>gameLoop

Func WinExit()
	Exit
EndFunc   ;==>WinExit
