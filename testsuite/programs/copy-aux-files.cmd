@echo off
rem This is a windows batch file.
rem This script copies auxiliary files into the testsuite\data directory.

rem preparations
setlocal enableextensions
set __olddir=%cd%
set __dir=%~dp0
set __script=%~nx0
set __workdir=%~dp0%..\data
cd %__workdir% || goto error

rem main program
set a=maya.pdf mfo.jpg snapshotmfo.cls trackchanges.sty
for %%f in (%a%) do (
  echo %__script%: copying %%f ...
  copy /y ..\..\%%f . || goto error
)
echo %__script%: The files %a% are necessary to compile the test files. So their latest versions have been copied into the testsuite\data directory.

:finish
cd %__olddir%
set /p d=Press RETURN to proceed! This may close the current window!
echo.
endlocal
exit /b 0

:error
cd %__olddir%
set /p d=Press RETURN to proceed! This may close the current window!
echo.
endlocal
exit /b 2
