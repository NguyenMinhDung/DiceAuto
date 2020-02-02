Func checkAds()
    If $GameState == 0 Or $GameState == $MAIN_SCREEN Then
        Local $result = _WaitForImageSearch($IMG_ADS, 3, 1)
    
        If IsArray($result) Then
            cr("Ads is found")

            $GameState = $ADS_SCREEN
        EndIf
    EndIf
EndFunc