Func checkDisconnect()
    If $GameState == 0 Or $GameState == $BATTLE_SCREEN Then
        cr("Checking disconnect...")
        Local $result = _WaitForImageSearch($IMG_DISCONNECT, 3, 1)

        If IsArray($result) Then
            Click($Title, $result[0], $result[1])
        EndIf
    EndIf
EndFunc