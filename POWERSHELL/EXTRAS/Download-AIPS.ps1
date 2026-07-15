$ProgressPreference = 'SilentlyContinue'

if (-not (Test-Path "$env:TEMP\Advanced_IP_Scanner_2.5.4594.1.exe")) {
    Invoke-WebRequest -Uri "https://download.advanced-ip-scanner.com/download/files/Advanced_IP_Scanner_2.5.4594.1.exe" -OutFile "$env:TEMP\Advanced_IP_Scanner_2.5.4594.1.exe"
}

& $env:TEMP\Advanced_IP_Scanner_2.5.4594.1.exe