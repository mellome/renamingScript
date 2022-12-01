@echo off
rem yhe
setlocal EnableDelayedExpansion
echo:
set /p s = please input extensional name: 

rem for /f %%i in ('dir /b *.txt') do (
for /r %%a in (.) do (
	echo %%a
	for /f %%i in ('dir /b "%%a\*.txt'") do (
		echo "%%i"
		rem ren %%i re_%%i
	)
)
echo successfully！
pause

