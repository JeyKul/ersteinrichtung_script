$ProgressPreference = 'SilentlyContinue'

if (-not (Test-Path "$env:TEMP\WhyNotWin11.exe")) {
    Invoke-WebRequest -Uri "https://github.com/rcmaehl/WhyNotWin11/releases/download/2.7.0/WhyNotWin11.exe" -OutFile "$env:TEMP\WhyNotWin11.exe"
}

& $env:TEMP\Advanced_IP_Scanner_2.5.4594.1.exe