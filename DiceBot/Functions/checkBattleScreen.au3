Func checkBattleScreen()
    If $GameState == 0 Or $GameState == $GAME_STARTED Then
        cr("Checking battle screen...")
        $NewDicePos = _WaitForImageSearch($IMG_NEW_DICE, 3, 1)

        If IsArray($NewDicePos) Then
            cr("Screen: Battle ")
            $NewDicePos = ScreenToClient($NewDicePos[0], $NewDicePos[1], $HWnD)
            $GameState = $BATTLE_SCREEN
        EndIf
    EndIf
EndFunc