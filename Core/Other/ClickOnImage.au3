Func ClickOnImage($imagePath, $timeout, $hwnd)
    Local $result = _WaitForImageSearch($imagePath, $timeout, 1)
    
    If IsArray($result) Then
        $result = ScreenToClient($result[0], $result[1], $hwnd)

        Click($hwnd, $result[0], $result[1])
        
        Return True
    EndIf
    
    Return False
EndFunc