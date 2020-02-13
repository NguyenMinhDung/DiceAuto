Func checkDisconnect()
    If $GameState == 0 Or $GameState == $BATTLE_SCREEN Then
        cr("Checking disconnect...")

        Local $result = _WaitForImageSearch($IMG_DISCONNECT, 3, 1)

        If IsArray($result) Then
            $GameState = $RESTART

            RestartApk("com.percent.royaldice")
        EndIf
    EndIf
EndFunc