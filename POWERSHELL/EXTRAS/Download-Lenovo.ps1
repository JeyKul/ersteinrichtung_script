$ProgressPreference = 'SilentlyContinue'

Write-Host "Downloading Lenovo Service Bridge"
if (-not (Test-Path "$env:TEMP\LSBSetup.exe")) {
    Invoke-WebRequest -Uri "https://download.lenovo.com/lsbv4/LSBSetup.exe" -OutFile "$env:TEMP\LSBSetup.exe"
}

Write-Host "Installing Lenovo Service Bridge"
& $env:TEMP\LSBSetup.exe /SILENT

start-sleep 5

Write-Host "Downloading Lenovo Service Bridge"
if (-not (Test-Path "$env:TEMP\system_update_5.08.03.59.exe")) {
    Invoke-WebRequest -Uri "https://download.lenovo.com/pccbbs/thinkvantage_en/system_update_5.08.03.59.exe" -OutFile "$env:TEMP\system_update_5.08.03.59.exe"
}

Write-Host "Installing system update 5.08.03.59 for Lenovo"
& $env:TEMP\system_update_5.08.03.59.exe /SILENT