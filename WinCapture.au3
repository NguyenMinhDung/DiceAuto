#include <WinAPISysWin.au3>
#include <WinAPIGdiDC.au3>
#include <WinAPIGdi.au3>

$hwnd = WinGetHandle('Calculator')
Screen_Handle($hwnd)

Func Screen_Handle($hwnd, $file = 'test.png')
  Local $iWidth = _WinAPI_GetWindowWidth($hwnd) ; $browser = the handle of the window which I am capturing
  Local $iHeight = _WinAPI_GetWindowHeight($hwnd)
  Local $hDDC = _WinAPI_GetDC($hwnd)
  Local $hCDC = _WinAPI_CreateCompatibleDC($hDDC)
  Local $hBitmap = _WinAPI_CreateCompatibleBitmap($hDDC, $iWidth, $iHeight)
  _WinAPI_SelectObject($hCDC, $hBitmap)
  _WinAPI_BitBlt($hCDC, 0, 0, $iWidth, $iHeight, $hDDC, 0, 0, 13369376)

  _WinAPI_SaveHBITMAPToFile($file,$hBitmap)
  _WinAPI_ReleaseDC($hWnd, $hDDC)
  _WinAPI_DeleteDC($hCDC)
  _WinAPI_DeleteObject($hBitmap)
EndFunc