$ProgressPreference = 'SilentlyContinue'

if (-not (Test-Path "$env:TEMP\WinDirStat.zip")) {
    Invoke-WebRequest -Uri "https://github.com/windirstat/windirstat/releases/latest/download/WinDirStat.zip" -OutFile "$env:TEMP\WinDirStat.zip"
}

if (-not (Test-Path "$env:TEMP\WinDirStat")) {
    Expand-Archive -Path "$env:TEMP\WinDirStat.zip" -DestinationPath "$env:TEMP\WinDirStat" -Force
}

if ($arch -eq "AMD64") {
    $exe = "$env:TEMP\WinDirStat\x64\WinDirStat.exe"
}
elseif ($arch -eq "ARM64") {
    $exe = "$env:TEMP\WinDirStat\arm64\WinDirStat.exe"
}
else {
    Write-Error "Unsupported architecture: $arch"
    exit 1
}

& $exe