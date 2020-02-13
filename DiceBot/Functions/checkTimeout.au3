Func checkTimeout($timeout)
    $timeout = $timeout * 1000
    
    If Not $AppRestart Then
        cr("Time Idle: " & TimerDiff($StartTime)/1000 & 's')

        If TimerDiff($StartTime) > $timeout Then
            $GameState = 0
            $StartTime = 0
            $AppRestart = True

            RestartApk("com.percent.royaldice")
        EndIf
    EndIf
EndFunc