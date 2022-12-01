@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
CHCP 65001
CLS

:: ======================
:: author: yhe
:: ======================

:: specify the new- and old name
rem set /p fileType="This renaming script can manage these two file types 'U325Z6-J00-01_图纸目录_A3.dwf' and 'U325Z6-J00-01_图纸目录[A3].dwf' " 
echo 使用须知:
echo 1. 该脚本可以处理以下两种命名规范的文件重命名: 'U325Z6-J00-01_图纸目录_A3.dwf' 和 'U325Z6-J00-01_图纸目录[A3].dwf'
echo 2. 原文件名内如若已存在图纸类型，该脚本不会二次添加图纸类型
echo 3. 图幅类型不做处理，需手动改动
echo:
echo 如若脚本继续运行，请回车确认，如若不是，请关闭终端窗口
pause
set _suffix=".dwf"

echo The following files have been found:
echo ==========================================

:: traverse the candidates
for /r %%F in (*.dwf) do (
	:: extract the name of candidates
	echo -path: %%F
	set "fileDir=%%F" 
	set "prefixName=%%~nF"

	:: initialize all variables
	set partA=""
	set partB=""
	set partC=""
	
	:: handle the character string of candidates
	:: the given string "<a>_<b>_<c>" 
	:: extract the part "<a>"
	for /f "tokens=1 delims=_" %%a in ("!prefixName!") do (
		set partA=%%a
	)

	:: extract the part "<b>"
	for /f "tokens=2 delims=_" %%b in ("!prefixName!") do (
		set partB=%%b

		:: check if the given substring exists
		set subStrRF=人防
		set subStrFL=防雷
		set subStrPM=平面
		set subStrZP=总平
		set subStrML=目录

		set drawingType=TY

		echo.!partB! | find "!subStrRF!">nul
		if !errorlevel!==0 (
			set drawingType=RF
			rem echo !drawingType!
		)
		echo.!partB! | find "!subStrFL!">nul
		if !errorlevel!==0 (
			set drawingType=FL
			rem echo !drawingType!
		)
		echo.!partB! | find "!subStrPM!">nul
		if !errorlevel!==0 (
			set drawingType=PM
			rem echo !drawingType!
		)
		echo.!partB! | find "!subStrZP!">nul
		if !errorlevel!==0 (
			set drawingType=ZP
			rem echo !drawingType!
		)
		echo.!partB! | find "!subStrML!">nul
		if !errorlevel!==0 (
			set drawingType=ML
			rem echo !drawingType!
		)

		for /f "tokens=2 delims=]" %%t in ("!partB!") do (
			echo %%t | findstr /i "RF FL ZP PM ML TY">nul
			if !errorlevel!==0 (
				set drawingType=
				rem echo !drawingType!
			)
		)
	)

	:: extract the part "<c>"
	for /f "tokens=3 delims=_" %%c in ("!prefixName!") do (
		set partC=%%c
	)
	if !partC!=="" (
		:: concatenate without <partC>
		set tempName=!partA!_!partB!!drawingType!
	) else (
		:: concatenate the character strings
		set tempName=!partA!_!partB![!partC!]!drawingType!
	)

	echo -before renaming: !prefixName!
	echo - after renaming: !tempName!
	echo: 
	rem pause

	:: execute renaming
	ren "%%F" "!tempName!!_suffix!"
)
echo ==========================================
echo Done
echo 请回车退出
pause
