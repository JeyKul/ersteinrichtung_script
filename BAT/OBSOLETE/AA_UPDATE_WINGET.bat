@echo off
setlocal

echo Downloading Winget MSIXBundle...

:: Set download URL and destination
set "url=https://aka.ms/getwinget"
set "file=%TEMP%\winget.msixbundle"

:: Download the file using PowerShell
powershell -Command "Invoke-WebRequest -Uri '%url%' -OutFile '%file%'"

if not exist "%file%" (
    echo Download failed.
    exit /b 1
)

echo Installing Winget...
powershell -Command "Add-AppxPackage -Path '%file%'"

if errorlevel 1 (
    echo Installation failed.
) else (
    echo Winget installed successfully.
)

endlocal
pause
