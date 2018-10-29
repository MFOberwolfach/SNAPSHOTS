@echo off
rem This is a windows batch file.
rem This script
rem  * copies auxiliary files into the data directory,
rem  * removes previous output,
rem  * compiles all test-*.tex files thoroughly,
rem  * merges the pdf output into all.pdf.

rem preparations
setlocal enableextensions
set __olddir=%cd%
set __dir=%~dp0
set __script=%~nx0
set __workdir=%~dp0%..\data
cd %__workdir% || goto error

rem main program
echo %__script%: start time: %date% %time:~0,8%

call %__dir%copy-aux-files.cmd || goto error

echo %__script%: removing previous output ...
del all.pdf test-*.aux test-*.bbl test-*.bib test-*.blg test-*.log test-*.out test-*.pdf || goto error

for %%f in (test-*.tex) do (
  echo %__script%: compiling %%~nf ...
  pdflatex %%~nf || goto error
  rem some test-*.tex do not cite anything, which causes bibtex to raise errors,
  rem so we allow the following command to have non-zero exit code:
  bibtex %%~nf
  pdflatex %%~nf || goto error
  pdflatex %%~nf || goto error
)

echo %__script%: merging pdf output into all.pdf ...
rem install pdftk-server from https://www.pdflabs.com
pdftk test-*.pdf cat output all.pdf || goto error

:finish
cd %__olddir%
echo %__script%: end time:   %date% %time:~0,8%
set /p d=Press RETURN to terminate the batch script! This may close the current window!
echo.
endlocal
exit /b

:error
cd %__olddir%
echo %__script%: end time:   %date% %time:~0,8%
set /p d=Press RETURN to terminate the batch script! This may close the current window!
echo.
endlocal
exit /b 2
