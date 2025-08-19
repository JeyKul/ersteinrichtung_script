Set-Location -Path $PSScriptRoot\..

POWERSHELL\EXT\NXTUpdateManager.exe -s -v -r -p
sleep 3
echo $pwd
POWERSHELL\EXT\NXTUpdateManager.exe -s -v -r -p