echo off
echo .
echo ------------------------------------------
echo Replace older MSCOMCTL.OCX with v6.1.98.46
echo .
echo If you did not start this batch with 'Run as Administrator',
echo please exit now; otherwise, press any key to continue
echo ------------------------------------------
echo .
pause
echo .
echo 1. Delete old registry entry
echo ----------------------------
reg delete hkcr\typelib\{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}\2.0 /f

if exist %systemroot%\SysWOW64\cscript.exe goto 64
echo .
echo 32bit Windows is not officially supported
echo .
echo 2. Unregister MSCOMCTL.OCX
echo -------------------------- 
%systemroot%\system32\regsvr32 /u mscomctl.ocx
echo .
echo 3. Register MSCOMCTL.OCX
echo ------------------------
%systemroot%\system32\regsvr32 mscomctl.ocx
exit
:64 
echo .
echo 64bit Windows Detected
echo .
echo 2. Unregister MSCOMCTL.OCX 
echo --------------------------
%systemroot%\sysWOW64\regsvr32 /u mscomctl.ocx
echo .
echo 3. Copy MSCOMCTL.OCX 
echo --------------------
Copy "%~dp0\mscomctl.ocx" "%systemroot%\sysWOW64"
echo .
echo 4. Register MSCOMCTL.OCX 
echo ------------------------
%systemroot%\sysWOW64\regsvr32 "%systemroot%\sysWOW64\mscomctl.ocx"
pause
exit