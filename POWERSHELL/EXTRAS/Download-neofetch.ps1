$ProgressPreference = 'SilentlyContinue'

if (-not (Test-Path "$env:TEMP\neofetch.exe")) {
    Invoke-WebRequest -Uri "https://github.com/nepnep39/neofetch-win/releases/latest/download/neofetch.exe " -OutFile "$env:TEMP\neofetch.exe"
}

clear
& $env:TEMP\neofetch.exe

Pause