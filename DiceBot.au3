#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Nguyen Beto

 Script Function:
	Automation for Royal Dice.

#ce ----------------------------------------------------------------------------
#pragma compile(Icon, "Icons\royaldice.ico")
#pragma compile(FileDescription, DiceBot)
#pragma compile(ProductName, DiceBot)
#pragma compile(ProductVersion, 2.7.0)
#pragma compile(FileVersion, 2.7.0)
#pragma compile(LegalCopyright, © The Free)

$sBotVersion = "2.7.0"
$sBotTitle = "AutoIt DiceBot v" & $sBotVersion

#include "General\Functions.au3"
#include "ImageSearch\ImageSearch.au3"
#include "Core\GlobalVariables.au3"
#include "Core\Functions.au3"
#include-once

HotKeySet("s", "Stop")

Func Stop()
	Exit
EndFunc

While (true)
	Sleep(1000)
WEnd