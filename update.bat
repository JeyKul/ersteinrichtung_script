@echo off
setlocal

cls

color 2
echo UPDATER

echo Current version
type %~dp0\ver

echo.
echo.
echo.
echo Latest version
type \\SRV-DC-2019\Daten$\Jey\ERSTEINRICHTUNG\ver


echo. 
echo. 
set /p confirm=Willst du den Ersteinrichtungs-Ordner updaten? (y/n): 

if /i not "%confirm%"=="y" (
    echo Abgebrochen.
    exit /b
)

set "source=\\SRV-DC-2019\Daten$\Jey\ERSTEINRICHTUNG\"
set "destination=%~dp0"

echo Kopiere Dateien von %source% nach %destination%...
xcopy "%source%" "%destination%" /D /E /H /Y

echo.
echo Update abgeschlossen.
color 7
cls
pause

