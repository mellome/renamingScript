@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

set newName=
set partA=
set partB=
set partC=
set drawingType=

:: the given string "<a>_<b>_<c>" 
set string=1.0.10_SNAPSHOT_suffix
echo %string%

:: extract the part "<a>"
for /f "tokens=1,2 delims=_" %%a in ("%string%") do (
    set partA=%%a
    echo !partA!
    pause
)

:: extract the part "<b>"
for /f "tokens=2 delims=_" %%b in ("%string%") do (
    set partB=%%b
    echo !partB!
    pause
    
    :: check if the given substring exists
    set subStr="SNAP"
    echo.!partB! | findstr "!subStr!">nul
    if !errorlevel!==0 (
        echo found it!
        set drawingType=TY
        echo !drawingType!
    )
)

:: extract the part "<c>"
for /f "tokens=3 delims=_" %%c in ("%string%") do (
    set partC=%%c
    echo !partC!
    pause
)

:: concatenate the character strings
set newName=%partA%%partB%[%partC%]%drawingType%
echo %newName%
pause


:: BACKUP
goto comment
    if "!partB:SHOT=!"=="!partB!"(
        echo "found it!"
        pause
    )
: comment