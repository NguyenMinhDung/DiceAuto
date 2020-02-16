#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Nguyen Beto

 Script Function: 
	Automation for Royal Dice.

#ce -------------------------------t---------------------------------------------
#pragma compile(Icon, "Icons\royaldice.ico")
#pragma compile(FileDescription, DiceBot)
#pragma compile(ProductName, DiceBot)
#pragma compile(ProductVersion, 3.2.0)
#pragma compile(FileVersion, 3.2.0)
#pragma compile(LegalCopyright, © The Free)

#include "DiceBot\GlobalVariables.au3"
#include "Core\Functions.au3"
#include "DiceBot\Functions.au3"
#include-once

_GDIPlus_Startup()

Local $NumCellEmpty = ScanDice()

FindPair()

_ArrayDisplay($DiceMatrix, "Dice Matrix", "", 0, "|", "X|Y|Dot|Name|Prioritize|Color|Center|Left|Right|Left Top|Left Bot|Right Top")

If $NumCellEmpty <= 1 Or $Pair[0][3] == 1 Then
    MergeDice($Pair[0][0], $Pair[0][1])
EndIf

ConsoleWrite($NumCellEmpty & " " & $Pair[0][3] & @CRLF)

_GDIPlus_Shutdown()

; cr(ColorCheck("EEF4F0", "F0F8F3", 5))

; 72E5E5

; CR(FindDiceType("67D64F"))