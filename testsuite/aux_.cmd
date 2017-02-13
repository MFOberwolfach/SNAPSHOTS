@echo off
rem This is a windows batch file.
rem Copy auxiliary files into testsuite folder.
rem The name aux without a trailing underscore is a reserved file name in MS Windows.

setlocal enableextensions
 
set m=0
set a=maya.pdf mfo.jpg snapshotmfo.cls trackchanges.sty
for %%f in (%a%) do (
  if not exist %%f (
    copy ..\%%f .
	set m=1
  )
)
if %m% equ 1 (
  echo The files %a% are necessary to compile the test files. Therefore the missing files have been copied into this folder.
  set /p d=Press RETURN to proceed! 
)

endlocal