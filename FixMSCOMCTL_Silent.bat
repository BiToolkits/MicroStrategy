echo working > "%~dp0\BiToolkits_working.flg"

NET SESSION
IF %ERRORLEVEL% NEQ 0 GOTO ELEVATE
GOTO ADMINTASKS

:ELEVATE
CD /d %~dp0
MSHTA "javascript: var shell = new ActiveXObject('shell.application'); shell.ShellExecute('%~nx0', '', '', 'runas', 1);close();"
GoTO :ExitAll

:ADMINTASKS

reg delete hkcr\typelib\{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}\2.0 /f

if exist %systemroot%\SysWOW64\cscript.exe goto 64 
echo Re-Register mscomctl.ocx
%systemroot%\system32\regsvr32 /u /s mscomctl.ocx
%systemroot%\system32\regsvr32 /s mscomctl.ocx
GoTO :ExitAll

:64 
echo Replace Re-Register mscomctl.ocx
%systemroot%\sysWOW64\regsvr32 /u /s mscomctl.ocx
Copy "%~dp0\mscomctl.ocx" "%systemroot%\sysWOW64"
%systemroot%\sysWOW64\regsvr32 /s "%systemroot%\sysWOW64\mscomctl.ocx"

:ExitAll
Del "%~dp0\BiToolkits_working.flg"
exit