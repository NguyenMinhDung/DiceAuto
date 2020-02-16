;==============================================================================================================
;==============================================================================================================
;===Color Variation============================================================================================
;--------------------------------------------------------------------------------------------------------------
;Checks if the color components exceed $sVari and returns true if they are below $sVari.
;--------------------------------------------------------------------------------------------------------------

Func ColorCheck($nColor1, $nColor2, $sVari = 5)
	If IsStringNullOrEmpty($nColor1) Or IsStringNullOrEmpty($nColor2) Then
		Return False
	EndIf

	Local $Red1, $Red2, $Blue1, $Blue2, $Green1, $Green2

	$Red1 = Dec(StringMid(String($nColor1), 1, 2))
	$Blue1 = Dec(StringMid(String($nColor1), 3, 2))
	$Green1 = Dec(StringMid(String($nColor1), 5, 2))

	$Red2 = Dec(StringMid(String($nColor2), 1, 2))
	$Blue2 = Dec(StringMid(String($nColor2), 3, 2))
	$Green2 = Dec(StringMid(String($nColor2), 5, 2))

	If Abs($Blue1 - $Blue2) > $sVari Then Return False
	If Abs($Green1 - $Green2) > $sVari Then Return False
	If Abs($Red1 - $Red2) > $sVari Then Return False
	Return True
EndFunc   ;==>_ColorCheck

Func IsStringNullOrEmpty($str)
    If $str == Null Or $str == "" Then 
        Return True 
    Else
        Return False
    EndIf
EndFunc

; CheckPixel : takes an array[4] as a parameter, [x, y, color, tolerance]
;Func CheckPixel($tab)
;	If ColorCheck(GetPixelColor($tab[0], $tab[1]), Hex($tab[2], 6), $tab[3]) Then Return True
;	Return False;
;EndFunc   ;==>CheckPixel
