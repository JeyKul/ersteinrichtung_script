$ProgressPreference = 'SilentlyContinue'

Write-Host "Downloading Powershell 7.6.0"
if (-not (Test-Path "$env:TEMP\PowerShell-7.6.0-win-x64.msi")) {
    Invoke-WebRequest -Uri "https://github.com/PowerShell/PowerShell/releases/download/v7.6.0/PowerShell-7.6.0-win-x64.msi" -OutFile "$env:TEMP\PowerShell-7.6.0-win-x64.msi"
}

Write-Host "Installing Powershell 7.6.0"
msiexec.exe /package $env:TEMP\PowerShell-7.6.0-win-x64.msi /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1 USE_MU=1 ENABLE_MU=1 ADD_PATH=1

start-sleep 5