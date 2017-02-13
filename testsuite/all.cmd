@echo off
rem This is a windows batch file.
rem Compile all test files and merge the output into a single pdf.

call aux_.cmd
del all.pdf test*.pdf
for %%f in (test*.tex) do (
  echo compiling %%f ...
  pdflatex %%f
)
rem install pdftk-server from https://www.pdflabs.com
pdftk test*.pdf cat output all.pdf

set /p d=Press RETURN to terminate the batch script. This may close the current window!
