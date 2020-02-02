#include <WindowsConstants.au3>
#include <GDIPlus.au3>

Opt("OnExitFunc", "endscript")
Opt("TrayMenuMode", 1)
Opt('MustDeclareVars', 1)

HotKeySet("{F11}", "_uzmi_sliku")
HotKeySet("{ESC}", "_izlaz")

Global $window_handle, $window_size, $window_size_x, $window_size_y, $iWbuffer, $iHbuffer
Global $window_width = @DesktopWidth / 2
Global $window_height = @DesktopHeight / 2

;speed up script by opening handles to frequently called dlls.
Global $hDLLUser32 = DllOpen("User32.dll")
Global $hDLLGDI32 = DllOpen("GDI32.dll")

Global $fFlag = False, $iPrevhWnd = 0, $iStart = 0
; no need to use WinGetHandle() with GUICreate() (old versions of AutoIt did return an integer instead of real handle)
Global $Form1 = GUICreate("Press F11 to capture window, press ESC to exit", $window_width, $window_height, -1, -1, $WS_CLIPSIBLINGS, $WS_EX_TOPMOST);+$WS_MINIMIZEBOX+$WS_SIZEBOX, $WS_EX_TOPMOST)
GUISetBkColor(0x000000)

_GDIPlus_Startup()
Global $hGraphic_x = _GDIPlus_GraphicsCreateFromHWND($Form1)
GUISetState(@SW_SHOWNOACTIVATE, $Form1)

TrayTip("", "Select another window," & @LF & "for example: Winamp or Firefox" & @LF & "then press F11" & @LF & @LF & "To quit press ESC", 30)
TraySetToolTip("to quit press ESC")

While 1
    Sleep(1000)
WEnd

;after the image is cleared from the gui with GraphicsClear it was repainted to the gui because although AdlibDisable
;is called, the Adlib function wont return until all internal functions are called.
;adding GraphicsClear to the Adlib function with a global boolean flag solves that problem.

;~ Func _postavi_novu_velicinu()
;~  _GDIPlus_GraphicsClear($hGraphic_x)
;~ EndFunc   ;==>_postavi_novu_velicinu

Func _uzmi_sliku()
    AdlibDisable()
;~  _postavi_novu_velicinu()
    $window_handle = WinGetHandle("[ACTIVE]")
    If @error Then Return 0
    
    ;desktop capture very glitchy
    Local $sClass = _WinAPI_GetClassName($window_handle)
    If $sClass == "WorkerW" Or $sClass == "Progman" Then Return 0

    Local $ihWnd = Number($window_handle) ; cast pointer to integer for comparison

    ;clear gui and return if gui form is active window
    If $ihWnd = Number($Form1) Then
        $fFlag = True
        Return 0
    EndIf

    ;if new window, clear gui of previous image (especially required if new window is smaller than previous)
    ;with the previous example script, the background areas not filled by the new window contained the previous window image
    If $ihWnd <> $iPrevhWnd And $iStart Then
        $iPrevhWnd = $ihWnd
        $fFlag = True
    EndIf
    
    If $iStart = 0 Then
        $iPrevhWnd = $ihWnd
        $iStart = 1
    EndIf
    
    ;preset position buffers to prevent clear graphic on first window capture
    $window_size = WinGetPos($window_handle)
    If @error Or Not IsArray($window_size) Then Return 0
    $iWbuffer = $window_size[2]
    $iHbuffer = $window_size[3]

    AdlibEnable("myadlib", 50)
EndFunc   ;==>_uzmi_sliku


Func myadlib()
    $window_size = WinGetPos($window_handle)
    If @error Or Not IsArray($window_size) Then Return 0

    If $window_size[2] <> $iWbuffer Or $window_size[3] <> $iHbuffer Then
        $iWbuffer = $window_size[2]
        $iHbuffer = $window_size[3]
        $fFlag = True ; clear graphic because target window was resized
    EndIf
    $window_size_x = $window_size[2] / 2
    $window_size_y = $window_size[3] / 2
    _ScreenShot_of_a_window($window_handle, $window_size_x, $window_size_y, $window_size[2], $window_size[3])
EndFunc   ;==>myadlib

Func _izlaz()
    AdlibDisable()
    endscript()
    DllClose($hDLLUser32)
    DllClose($hDLLGDI32)
    Exit
EndFunc   ;==>_izlaz

Func endscript()
    _GDIPlus_GraphicsDispose($hGraphic_x)
    _GDIPlus_Shutdown()
EndFunc   ;==>endscript

Func _ScreenShot_of_a_window($i_win_handle, $iW, $iH, $iW2, $iH2)
    Local $aRet = DllCall($hDLLUser32, "hwnd", "GetWindowDC", "hwnd", $i_win_handle)
    If @error Then Return SetError(@error, 0, -1)
    Local $hDC = $aRet[0]
    $aRet = DllCall($hDLLGDI32, "hwnd", "CreateCompatibleDC", "hwnd", $hDC)
    If @error Then Return SetError(@error, 0, -1)
    Local $hMemDC = $aRet[0]
    $aRet = DllCall($hDLLGDI32, "hwnd", "CreateCompatibleBitmap", "hwnd", $hDC, "int", $iW2, "int", $iH2)
    If @error Then Return SetError(@error, 0, -1)
    Local $hBitmap = $aRet[0]
    $aRet = DllCall($hDLLGDI32, "hwnd", "SelectObject", "hwnd", $hMemDC, "hwnd", $hBitmap)
    If @error Then Return SetError(@error, 0, -1)
    Local $hOld = $aRet[0]
    $aRet = DllCall($hDLLUser32, "int", "ReleaseDC", "hwnd", $i_win_handle, "hwnd", $hDC)
    If @error Then Return SetError(@error, 0, -1)
    _PrintWindow($i_win_handle, $hMemDC)
    $aRet = DllCall($hDLLGDI32, "hwnd", "SelectObject", "hwnd", $hMemDC, "hwnd", $hOld)
    If @error Then Return SetError(@error, 0, -1)
    $aRet = DllCall($hDLLGDI32, "int", "DeleteDC", "hwnd", $hMemDC)
    If @error Then Return SetError(@error, 0, -1)
    _SavehBitmapEx($hBitmap, $iW, $iH)
    $aRet = DllCall($hDLLGDI32, "int", "DeleteObject", "int", $hBitmap)
    If @error Then Return SetError(@error, 0, -1)
    
    ;clear gui form and return if AdlibDisable() called
    If $fFlag Then
        _GDIPlus_GraphicsClear($hGraphic_x)
        $fFlag = False
        Return 0
    EndIf
EndFunc   ;==>_ScreenShot_of_a_window

Func _SavehBitmapEx($hBitmap, $iWidth, $iHeight)
    Local $bitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap)
    Local $graphics = _GDIPlus_ImageGetGraphicsContext($bitmap)
    Local $resizedbitmap = _GDIPlus_BitmapCreateFromGraphics($iWidth, $iHeight, $graphics)
    Local $graphics2 = _GDIPlus_ImageGetGraphicsContext($resizedbitmap)
    _GDIPLUS_GraphicsSetInterpolationMode($graphics2, 2)
    _GDIPlus_GraphicsDrawImageRect($graphics2, $bitmap, 0, 0, $iWidth, $iHeight)
    _GDIPlus_GraphicsDrawImage($hGraphic_x, $resizedbitmap, 0, 0)
    _GDIPlus_GraphicsDispose($graphics)
    _GDIPlus_GraphicsDispose($graphics2)
    _GDIPlus_BitmapDispose($bitmap)
    _GDIPlus_BitmapDispose($resizedbitmap)
EndFunc   ;==>_SavehBitmapEx

Func _GDIPLUS_GraphicsSetInterpolationMode($hGraphics, $iMode)
    DllCall($ghGDIPDll, "int", "GdipSetInterpolationMode", "hwnd", $hGraphics, "int", $iMode)
EndFunc   ;==>_GDIPLUS_GraphicsSetInterpolationMode

Func _PrintWindow($hWnd, $hMemDC, $iFlag = 0)
    Local $aRet = DllCall($hDLLUser32, "int", "PrintWindow", _
            "hwnd", $hWnd, _
            "hwnd", $hMemDC, _
            "int", $iFlag)
    Return $aRet[0]
EndFunc   ;==>_PrintWindow