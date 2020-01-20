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
#include <GUIConstantsEx.au3>
#include <SendMessage.au3>
#include <WindowsConstants.au3>
#include-once

Global Const $SC_DRAGMOVE = 0xF012

createGUI()

Func createGUI()
    Local $iHeight = 60, $iWidth = 215

    Local $hGUI = GUICreate('Auto Dice', $iWidth, $iHeight, Default, Default, BitOR($WS_POPUP, $WS_BORDER), $WS_EX_TOPMOST)
    GUICtrlCreateGroup('', 0, -5, $iWidth, $iHeight + 5, $WS_THICKFRAME)
	GUICtrlCreateGroup('', -99, -99, 1, 1)
	Local $iStart = GUICtrlCreateButton('Start', $iWidth - 195, $iHeight - 40, 85, 25)
    Local $iClose = GUICtrlCreateButton('Close', $iWidth - 100, $iHeight - 40, 85, 25)

    GUISetState(@SW_SHOW, $hGUI)

    While 1
		Switch GUIGetMsg()
			Case $iStart
				runBot()

            Case $GUI_EVENT_CLOSE, $iClose
                ExitLoop

        EndSwitch
    WEnd

    GUIDelete($hGUI)
EndFunc

Func runBot()
	
EndFunc