Func viewAds()
    If $GameState == $ADS_SCREEN Then
        cr("Viewing ad")

        Local $result = ClickOnImage($IMG_ADS, 3, $HWnD)

        Sleep(5000)

        Local $mainScreen = _WaitForImageSearch($IMG_MAIN_SCREEN, 5, 1)

        If $result And Not IsArray($mainScreen) Then
            
            ResetStartTime()

            $GameState = $VIEWING_AD
        Else
            $GameState = $RESTART
            $AppRestart = True

            RestartApk("com.percent.royaldice")
        EndIf
    EndIf
EndFunc