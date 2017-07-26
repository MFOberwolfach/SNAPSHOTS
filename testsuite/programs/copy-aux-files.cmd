@echo off
rem This is a windows batch file.
rem This script copies auxiliary files into the testsuite/data directory.

rem preparations
setlocal enableextensions
set __olddir=%cd%
set __dir=%~dp0
set __script=%~nx0
set __workdir=%~dp0%..\data
cd %__workdir% || goto error

rem main program
set m=0
set a=maya.pdf mfo.jpg snapshotmfo.cls trackchanges.sty
for %%f in (%a%) do (
  if not exist %%f (
    echo %__script%: copying %%f ...
    copy ..\..\%%f . || goto error
	set m=1
  )
)
if %m% equ 1 (
  echo %__script%: The files %a% are necessary to compile the test files. Therefore the missing files have been copied into this folder.
) else (
  echo %__script%: Copies of the files %a% are already in the data directory.
)

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
