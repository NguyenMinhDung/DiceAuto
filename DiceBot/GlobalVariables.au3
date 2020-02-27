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

Const $EMPTY_CELL_COLOR = "DBDBDB"
Const $SPACE_COLOR = "FFFFFF"
Const $BLACK_COLOR = "000000"

Global $LeftTopCellPosition = [1579, 391, 1, Null, 0, Null]
Global $Pair = [[0, 0, 7, 10]]

Global $DiceMatrix[15][12]
;["Ice", 2, "4090F3"], _
;["Posion", 2, "67D64F"], _
;["Summoner", 1, "00A736"], _
Global $DiceBattleTable = [ _
    ["Blizzard", 2, "377DED", "377DEE"], _
    ["Typhoon", 4, "187483", "0E284F", "0E2850"], _
    ["MightyWind", 3, "72E5E5", "356BDF", "66CDDE", "142F5A"], _
    ["Growth", 0, "3B2892"], _
    ["Modified", 2, "FF6C66"] _
]

Global $PendingMerge = 0
Global $LimitForMerge = 0

#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <Array.au3>
#include <ScreenCapture.au3>

InitPositionDice()

Func ResetStartTime()
    $StartTime = TimerInit()
    $AppRestart = False
EndFunc