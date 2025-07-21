Set-Location -Path $PSScriptRoot\..

.\EXE\NXTUpdateManager.exe -s -v -r -p
sleep 3
.\EXE\NXTUpdateManager.exe -s -v -r -p