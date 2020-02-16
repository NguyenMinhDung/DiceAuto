Local $MouseVals[15] =["AppStarting","Arrow","Crosshair","Hand","Help","IBeam","No","NWPen","SizeAll","SizeNESW","SizeNS","SizeNWSE","SizeWE","UpArrow","Wait"]
Local $MouseShow[15] = ["aero_working.cur", False, False, "aero_link.cur", "aero_helpsel.cur", False, "aero_unavail.cur", "aero_pen.cur", "aero_move.cur", "aero_nesw.cur", "aero_ns.cur", "aero_nwse.cur", "aero_ew.cur", "aero_up.cur", "aero_busy.cur"]

Func HidePointer($HidePointer)
     If $HidePointer Then
		  For $A = 0 to 14
			RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", $MouseVals[$A], "REG_EXPAND_SZ", @ScriptDir & "\invisible.cur")
          Next
     Else
		  For $A = 0 to 14
			If $MouseShow[$A] <> False Then
			   	RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", $MouseVals[$A], "REG_EXPAND_SZ", "%SYSTEMROOT%\Cursors\" & $MouseShow[$A])
			Else
				RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", $MouseVals[$A], "REG_EXPAND_SZ", "")
			EndIf
          Next
     EndIf
     DllCall("user32.dll", "int", "SystemParametersInfo", "int", 0x57, "int", 0, "int", 0, "int", 0)
EndFunc