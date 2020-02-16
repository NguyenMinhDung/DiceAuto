Func CaptureRegion()
    Local $aPos = WinGetPos($hWnD)

    Local $hHBitmap = _ScreenCapture_Capture("", $aPos[0], $aPos[1], $aPos[0] + $aPos[2], $aPos[1] + $aPos[3])

    $HBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hHBitmap)
EndFunc