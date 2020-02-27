Global $Title = "NoxPlayer" ; Name of the Window
Global $HWnD = WinGetHandle($Title) ;Handle for Bluestacks window

; AdbCommand
Global $Nox_Path = "D:\Program Files\Nox\bin"
Global $Adb = "nox_adb.exe"

; DiceBot
Global $ApkPackage = "com.percent.royaldice"
Global $IsRunning = False
Global $IsPause = False

Global $AppRestart = False
Global $GameState = 0
Enum $MAIN_SCREEN = 1, $ADS_SCREEN, $VIEWING_AD, $ALLI_MODE_POPUP, $GAME_STARTED, $BATTLE_SCREEN, $RESTART

Global $ConfigFile = @ScriptDir & "\config.ini"

Global $NewDicePos
Global $CurUpgradeDice = 1
Global $NewDiceCount = 0

Global $slot1[2] = [70, 641]
Global $slot2[2] = [70, 641]
Global $slot3[2] = [190, 641]
Global $slot4[2] = [250, 641]
Global $slot5[2] = [310, 641]

Global $slot = 1

Global $StartTime = TimerInit()

; Images
Global $IMG_MAIN_SCREEN = "Images\main_screen.png"
Global $IMG_ADS = "Images\ads.png"
Global $IMG_PVE = "Images\pve.png"
Global $IMG_QUICK_MATCH = "Images\quick_match.png"
Global $IMG_NEW_DICE = "Images\new_dice.png"
Global $IMG_DISCONNECT = "Images\disconnect.png"

#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <Array.au3>
#include <ScreenCapture.au3>

Func ResetStartTime()
    $StartTime = TimerInit()
    $AppRestart = False
EndFunc