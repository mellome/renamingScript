@echo off
call :treeProcess
goto :eof

:treeProcess
rem Do whatever you want here over the files of this subdir, for example:
for %%f in (*.txt) do (
	echo %%f
	rem ren %%f re_%%f
	set new_name=%\%%f:test=T% 
	ren %%f %new_name%
	echo %%f
)
for /D %%d in (*) do (
    cd %%d
    call :treeProcess
    cd ..
)
pause
