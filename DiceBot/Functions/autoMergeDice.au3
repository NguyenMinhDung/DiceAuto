Local $HexColorCenter
Local $HexColorLeft
Local $HexColorRight
Local $HexColorLeftTop
Local $HexColorRightTop
Local $HexColorLeftBot

Func InitPositionDice()
    For $x = 0 To 2
        For $y = 0 To 4
            $DiceMatrix[5 * $x + $y][0] = $LeftTopCellPosition[0] + 44 * $y
            $DiceMatrix[5 * $x + $y][1] = $LeftTopCellPosition[1] + 42 * $x
            $DiceMatrix[5 * $x + $y][2] = $LeftTopCellPosition[2]
            $DiceMatrix[5 * $x + $y][3] = $LeftTopCellPosition[3]
            $DiceMatrix[5 * $x + $y][4] = $LeftTopCellPosition[4]
        Next    
    Next
EndFunc

Func ScanDice()

    CaptureRegion()

    _GDIPlus_ImageSaveToFile($HBitmap, @ScriptDir & "\test.jpg")

    Local $NumCellEmpty = 0

    For $Cell = 0 To UBound($DiceMatrix) - 1
        UpdateDot($Cell)
        
        If Not $DiceMatrix[$Cell][3] Then
            $NumCellEmpty = $NumCellEmpty + 1
        EndIf
    Next

    Return $NumCellEmpty
EndFunc

Func FindPair()
    $Pair[0][0] = 0
    $Pair[0][1] = 0
    $Pair[0][2] = 7
    $Pair[0][3] = 10

    For $Row = 0 To UBound($DiceMatrix) - 2
        For $NextRow = $Row + 1 To UBound($DiceMatrix) - 1
            If $DiceMatrix[$Row][2] > 0 And $DiceMatrix[$NextRow][2] And _
                $DiceMatrix[$Row][2] == $DiceMatrix[$NextRow][2] And _
                $DiceMatrix[$Row][3] == $DiceMatrix[$NextRow][3] And _
                $DiceMatrix[$Row][3] <> $EMPTY_CELL_COLOR Then
                
                If $DiceMatrix[$Row][4] > 0 And $Pair[0][3] > 1 And ($Pair[0][2] > $DiceMatrix[$Row][2] Or $Pair[0][3] > $DiceMatrix[$Row][4]) Then ; Uu tien so dot nho hon va uu tien nho hon

                    $Pair[0][0] = $Row
                    $Pair[0][1] = $NextRow
                    $Pair[0][2] = $DiceMatrix[$Row][2]
                    $Pair[0][3] =  $DiceMatrix[$Row][4]
                EndIf
            EndIf
        Next
    Next
EndFunc

Func MergeDice($Source, $Dest)
    MouseClickDrag("left", $DiceMatrix[$Source][0], $DiceMatrix[$Source][1], $DiceMatrix[$Dest][0], $DiceMatrix[$Dest][1])
EndFunc

;Func GetCenterPos()
;    Local $Pos = [$DiceMatrix[$Cell][0], $DiceMatrix[$Cell][1]]
;    $Pos = ScreenToClient($Pos[0], $Pos[1], $HWnD)
;    Return $Pos
;EndFunc

Func UpdateOneDot($Cell)
    If IsValidColor($DiceMatrix[$Cell][5]) Then
        $DiceMatrix[$Cell][2] = 1
    Else
        $DiceMatrix[$Cell][2] = 0
    EndIf
EndFunc

Func UpdateTwoDot($Cell)
    If ColorCheck($HexColorLeftBot, $DiceMatrix[$Cell][5]) And Not ColorCheck($HexColorLeftBot, $HexColorCenter) And Not ColorCheck($HexColorLeftBot, $HexColorLeftTop) Then
        $DiceMatrix[$Cell][2] = 2
    Else
        UpdateOneDot($Cell)
    EndIf
EndFunc

Func UpdateThreeDot($Cell)
    If Not ColorCheck($HexColorCenter, $HexColorLeftTop) And ColorCheck($HexColorCenter, $DiceMatrix[$Cell][5]) And ColorCheck($HexColorCenter, $HexColorLeftBot) Then
        $DiceMatrix[$Cell][2] = 3
    Else
        UpdateTwoDot($Cell)
    EndIf
EndFunc

Func UpdateFourDot($Cell)
    If Not ColorCheck($HexColorCenter, $DiceMatrix[$Cell][5]) And ColorCheck($DiceMatrix[$Cell][5], $HexColorRightTop) _
        And ColorCheck($DiceMatrix[$Cell][5], $HexColorLeftBot) And ColorCheck($HexColorLeftTop, $HexColorRightTop) Then
        $DiceMatrix[$Cell][2] = 4
    Else
        UpdateThreeDot($Cell)
    EndIf
EndFunc

Func UpdateFiveDot($Cell)
    If ColorCheck($DiceMatrix[$Cell][5], $HexColorLeftTop) And ColorCheck($DiceMatrix[$Cell][5], $HexColorRightTop) Then
        $DiceMatrix[$Cell][2] = 5
    Else
        UpdateFourDot($Cell)
    EndIf
EndFunc

Func UpdateSixDot($Cell)
    If ColorCheck($DiceMatrix[$Cell][5], $HexColorRight) And ColorCheck($DiceMatrix[$Cell][5], $HexColorLeftTop) And ColorCheck($DiceMatrix[$Cell][5], $HexColorLeftBot) _
         And Not ColorCheck($HexColorCenter, $DiceMatrix[$Cell][5]) Then
        $DiceMatrix[$Cell][2] = 6
    Else
        UpdateFiveDot($Cell)
    EndIf
EndFunc

Func UpdateDot($Cell)
    Local $Pos = [$DiceMatrix[$Cell][0], $DiceMatrix[$Cell][1]]
    $Pos = ScreenToClient($Pos[0], $Pos[1], $HWnD)

    $HexColorCenter = GetPixelColor($Pos[0], $Pos[1], $HBitmap)
    $HexColorLeft = GetPixelColor($Pos[0] - 8, $Pos[1], $HBitmap)
    $HexColorRight = GetPixelColor($Pos[0] + 8, $Pos[1], $HBitmap)
    $HexColorLeftTop = GetPixelColor($Pos[0] - 8, $Pos[1] - 8, $HBitmap)
    $HexColorRightTop = GetPixelColor($Pos[0] + 8, $Pos[1] - 8, $HBitmap)
    $HexColorLeftBot = GetPixelColor($Pos[0] - 8, $Pos[1] + 8, $HBitmap)

    $DiceMatrix[$Cell][6] = $HexColorCenter
    $DiceMatrix[$Cell][7] = $HexColorLeft
    $DiceMatrix[$Cell][8] = $HexColorRight
    $DiceMatrix[$Cell][9] = $HexColorLeftTop
    $DiceMatrix[$Cell][10] = $HexColorLeftBot
    $DiceMatrix[$Cell][11] = $HexColorRightTop

    UpdateDiceType($Cell)

    UpdateSixDot($Cell)
EndFunc

Func UpdateDiceType($Cell)
    For $i = 6 To 11
        Local $diceTypeIndex = FindDiceType($DiceMatrix[$Cell][$i])

        If $diceTypeIndex >= 0 Then
            $DiceMatrix[$Cell][3] = $DiceBattleTable[$diceTypeIndex][0]
            $DiceMatrix[$Cell][4] = $DiceBattleTable[$diceTypeIndex][1]
            $DiceMatrix[$Cell][5] = $DiceMatrix[$Cell][$i]

            ExitLoop
        Else
            $DiceMatrix[$Cell][3] = Null
            $DiceMatrix[$Cell][4] = 0
            $DiceMatrix[$Cell][5] = ""
        EndIf
    Next
EndFunc

Func FindDiceType($Color)
    If IsValidColor($Color) Then
        for $row = 0 to UBound($DiceBattleTable) - 1
            For $col = 2 To  UBound($DiceBattleTable, 2) - 1
                If ColorCheck($Color, $DiceBattleTable[$row][$col]) Then
    
                    Return $row
                EndIf
            Next
        Next
    EndIf

    Return -1
EndFunc

Func IsValidColor($Color)
    Return $Color <> Null And $Color <> "" And Not ColorCheck($Color, $EMPTY_CELL_COLOR) And Not ColorCheck($Color, $SPACE_COLOR) And $Color <> $BLACK_COLOR 
EndFunc