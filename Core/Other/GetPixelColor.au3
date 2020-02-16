Func CaptureWindow($hWnd, $w, $h)
    If Not IsHWnd($hWnd) Then Return SetError(1, 0, 0)
    If Int($w) < 1 Then Return SetError(2, 0, 0)
    If Int($h) < 1 Then Return SetError(3, 0, 0)
    Local Const $hDC_Capture = _WinAPI_GetDC(HWnd($hWnd))
    Local Const $hMemDC = _WinAPI_CreateCompatibleDC($hDC_Capture)
    Local Const $hHBitmap = _WinAPI_CreateCompatibleBitmap($hDC_Capture, $w, $h)
    Local Const $hObjectOld = _WinAPI_SelectObject($hMemDC, $hHBitmap)
    DllCall("gdi32.dll", "int", "SetStretchBltMode", "hwnd", $hDC_Capture, "uint", 4)
    DllCall("user32.dll", "int", "PrintWindow", "hwnd", $hWnd, "handle", $hMemDC, "int", 0)

    _WinAPI_DeleteDC($hMemDC)
    _WinAPI_SelectObject($hMemDC, $hObjectOld)
    _WinAPI_ReleaseDC($hWnd, $hDC_Capture)

    Local Const $hFullScreen = WinGetHandle("[TITLE:Program Manager;CLASS:Progman]")
    Local Const $aFullScreen = WinGetPos($hFullScreen)
    Local Const $c1 = $aFullScreen[2] - @DesktopWidth, $c2 = $aFullScreen[3] - @DesktopHeight
    Local Const $wc1 = $w - $c1, $hc2 = $h - $c2

    If (($wc1 > 1 And $wc1 < $w) Or ($w - @DesktopWidth > 1) Or ($hc2 > 7 And $hc2 < $h) Or ($h - @DesktopHeight > 1)) And (BitAND(WinGetState(HWnd($hWnd)), 32) = 32) Then
        Local $hBmp_t = _GDIPlus_BitmapCreateFromHBITMAP($hHBitmap)
        $hBmp = _GDIPlus_BitmapCloneArea($hBmp_t, 8, 8, $w - 16, $h - 16)
        _GDIPlus_BitmapDispose($hBmp_t)
    Else
        $hBmp = _GDIPlus_BitmapCreateFromHBITMAP($hHBitmap)
    EndIf
    _WinAPI_DeleteObject($hHBitmap)
    Return $hBmp
EndFunc   ;==>Capture_Window

Func GetPixelColor($iX, $iY, $hBitmap)
    Local $aPixelColor = _GDIPlus_BitmapGetPixel($hBitmap, $iX, $iY)
	Return Hex($aPixelColor, 6)
EndFunc   ;==>_GetPixelColor

Func WinGetPixelColor($iX, $iY, $hWindow)
    Local $aPos = WinGetPos($hWindow)

    Local $hHBitmap = _ScreenCapture_Capture("", $aPos[0], $aPos[1], $aPos[0] + $aPos[2], $aPos[1] + $aPos[3])

    Local $BMP = _GDIPlus_BitmapCreateFromHBITMAP($hHBitmap)

    Return GetPixelColor($iX, $iY, $BMP)
EndFunc

Func GetColor($iX, $iY, $WinHandle)

    Local $aPos = WinGetPos($WinHandle)

    $iWidth = $aPos[2]
    $iHeight = $aPos[3]

    _GDIPlus_Startup()

    Local $hDDC = _WinAPI_GetDC($WinHandle)
    Local $hCDC = _WinAPI_CreateCompatibleDC($hDDC)

    $hBMP = _WinAPI_CreateCompatibleBitmap($hDDC, $iWidth, $iHeight)

    _WinAPI_SelectObject($hCDC, $hBMP)
    DllCall("User32.dll", "int", "PrintWindow", "hwnd", $WinHandle, "hwnd", $hCDC, "int", 0)
    _WinAPI_BitBlt($hCDC, 0, 0, $iWidth, $iHeight, $hDDC, 0, 0, $__SCREENCAPTURECONSTANT_SRCCOPY)

    $BMP = _GDIPlus_BitmapCreateFromHBITMAP($hBMP)

    _WinAPI_SaveHBITMAPToFile(@MyDocumentsDir & "\test.png", $hBMP)

    Local $aPixelColor = _GDIPlus_BitmapGetPixel($BMP, $iX, $iY)

    _WinAPI_ReleaseDC($WinHandle, $hDDC)
    _WinAPI_DeleteDC($hCDC)
    _WinAPI_DeleteObject($hBMP)
    _GDIPlus_ImageDispose($BMP)

    Return Hex($aPixelColor, 6)
EndFunc   ;==>GetColor