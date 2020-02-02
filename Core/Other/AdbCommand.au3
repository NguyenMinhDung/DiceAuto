#include <AutoItConstants.au3>

Func AdbCommand($Command, $WorkingDir = @ScriptDir)
	$DOS = Run($Nox_Path & "\" & $Command, $Nox_Path, @SW_HIDE, $STDERR_MERGED)
	While 1
		Sleep(50)
		If @error Or Not ProcessExists($DOS) Then ExitLoop
	WEnd
	$Message = StdoutRead($DOS)
	Return $Message
EndFunc   ;==>AdbCommand

Func AdbTap($x, $y)
	AdbCommand($Adb & " shell input tap " & $x & " " & $y & "")
EndFunc   ;==>AdbTap

Func StartApk($package)
	AdbCommand($Adb & " shell monkey -p " & $package & " -c android.intent.category.LAUNCHER 1")
EndFunc   ;==>StartApk

Func StopApk($package)
	AdbCommand($Adb & " shell am force-stop " & $package)
EndFunc   ;==>StopApk

Func RestartApk($package)
	StopApk($package)
	StartApk($package)
EndFunc   ;==>RestartApk
