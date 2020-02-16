Global $Title = "NoxPlayer" ; Name of the Window
Global $HWnD = WinGetHandle($Title) ;Handle for Bluestacks window
Global $HBitmap

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

Global $slot1[2] = [100, 921]
Global $slot2[2] = [460, 921]
Global $slot3[2] = [280, 921]
Global $slot4[2] = [370, 921]
Global $slot5[2] = [460, 921]

Global $slot = 1

Global $StartTime = TimerInit()

; Images
Global $IMG_MAIN_SCREEN = "Images\main_screen.png"
Global $IMG_ADS = "Images\ads.png"
Global $IMG_PVE = "Images\pve.png"
Global $IMG_QUICK_MATCH = "Images\quick_match.png"
Global $IMG_NEW_DICE = "Images\new_dice.png"
Global $IMG_DISCONNECT = "Images\disconnect.png"

Const $EMPTY_CELL_COLOR = "DBDBDB"
Const $SPACE_COLOR = "FFFFFF"
Const $BLACK_COLOR = "000000"

Global $LeftTopCellPosition = [1454, 558, 1, Null, 0, Null]
Global $Pair = [[0, 0, 7, 10]]

Global $DiceMatrix[15][12]
Global $DiceBattleTable = [ _
    ["IceDice", 2, "4090F3"], _
    ["Posion", 2, "67D64F"], _
    ["MightyWindDice", 3, "72E5E5", "356BDF", "66CDDE", "142F5A"], _
    ["SummonerDice", 1, "00A736"], _
    ["ModifiedDice", 2, "FF6C66"] _
]

#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <Array.au3>
#include <ScreenCapture.au3>

InitPositionDice()

Func ResetStartTime()
    $StartTime = TimerInit()
    $AppRestart = False
EndFunc