Func ScreenToClientP($pos, $hWnd)
    Return ScreenToClient($pos[0], $pos[1], $hWnd)
EndFunc

Func ScreenToClient($x, $y, $hWnd)
    Local $tpoint = DllStructCreate("int X;int Y")
	DllStructSetData($tpoint, "X", $x)
	DllStructSetData($tpoint, "Y", $y)
    _WinAPI_ScreenToClient($hWnd, $tpoint)

    Dim $rPoint[2] = [DllStructGetData($tpoint, "X"), DllStructGetData($tpoint, "Y")]
    
    Return $rPoint
EndFunc