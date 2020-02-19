#cs ----------------------------------------------------------------------------
 AutoIt Version: 3.2.8.1
 Author:         someone
 Script Function:
    MouseClickPlus
#ce ----------------------------------------------------------------------------
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

Local $Button
Local $ButtonDown
Local $ButtonUp

_MouseClickPlus($HWnD, Default, 0,0, 1625,432)

Func _MouseClickPlus($Window, $Button="left", $X1=0, $Y1=0, $X2=0, $Y2=0, $Clicks=1)
    Local $MK_LBUTTON       =  0x0001
    Local $WM_LBUTTONDOWN   =  0x0201
    Local $WM_LBUTTONUP     =  0x0202
  
    Local $MK_RBUTTON       =  0x0002
    Local $WM_RBUTTONDOWN   =  0x0204
    Local $WM_RBUTTONUP     =  0x0205
  
    Local $WM_MOUSEMOVE     =  0x0200
  
    Local $i                = 0
  
    Select
    Case $Button = "left"
       $Button     =  $MK_LBUTTON
       $ButtonDown =  $WM_LBUTTONDOWN
       $ButtonUp   =  $WM_LBUTTONUP
    Case $Button = "right"
       $Button     =  $MK_RBUTTON
       $ButtonDown =  $WM_RBUTTONDOWN
       $ButtonUp   =  $WM_RBUTTONUP
    EndSelect
  
    If $X1 = 0 OR $Y1 = 0 Then
       $MouseCoord = MouseGetPos()
       $X1 = $MouseCoord[0]
       $Y1 = $MouseCoord[1]
    EndIf

    ConsoleWrite($Window)
  
    For $i = 1 to $Clicks
       DllCall("user32.dll", "int", "SendMessage", _
          "hwnd",  WinGetHandle($Window), _
          "int",   $WM_MOUSEMOVE, _
          "int",   0, _
          "long",  _MakeLong($X1, $Y1))

          Sleep(1000)
  
       DllCall("user32.dll", "int", "SendMessage", _
          "hwnd",  WinGetHandle($Window), _
          "int",   $ButtonDown, _
          "int",   $Button, _
          "long",  _MakeLong($X1, $Y1))

          Sleep(1000)
  
    ;~    DllCall("user32.dll", "int", "SendMessage", _
    ;~       "hwnd",  WinGetHandle($Window), _
    ;~       "int",   $WM_MOUSEMOVE, _
    ;~       "int",   0, _
    ;~       "long",  _MakeLong($X2, $Y2))
  
    ;~    DllCall("user32.dll", "int", "SendMessage", _
    ;~       "hwnd",  WinGetHandle($Window), _
    ;~       "int",   $ButtonUp, _
    ;~       "int",   $Button, _
    ;~       "long",  _MakeLong($X2, $Y2))
    Next
  EndFunc
  
  Func _MakeLong($LoWord,$HiWord)
    Return BitOR($HiWord * 0x10000, BitAND($LoWord, 0xFFFF))
  EndFunc