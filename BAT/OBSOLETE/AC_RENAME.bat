@echo off
setlocal

:: Check if a name was provided as an argument
if "%~1"=="" (
    set /p NEWNAME=Enter the new computer name: 
) else (
    set NEWNAME=%~1
)

:: Get current computer name
for /f "tokens=2 delims==" %%a in ('wmic computersystem get name /value ^| find "="') do (
    set CURRENTNAME=%%a
)

if /i "%NEWNAME%"=="%CURRENTNAME%" (
    echo The computer name is already "%NEWNAME%". No changes made.
    goto :EOF
)

:: Rename the computer
wmic computersystem where name="%COMPUTERNAME%" call rename name="%NEWNAME%"
if errorlevel 1 (
    echo Failed to rename the computer.
) else (
    echo Computer name changed from "%CURRENTNAME%" to "%NEWNAME%".
    echo Please restart the computer manually to apply the change.
)

endlocal
