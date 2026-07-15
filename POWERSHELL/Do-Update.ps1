# ======================================
# Self-Updating Script
# ======================================

# Paths
$serverVerFile = "\\SRV-DC-2019\Daten$\Jey\Ersteinrichtung rebase\ver"
$localVerFile  = Join-Path $rootDir "ver"
$sourceDir     = "\\SRV-DC-2019\Daten$\Jey\Ersteinrichtung rebase"

# Function to read version info safely
function Get-VersionInfo {
    param ($path)
    if (Test-Path $path) {
        return Get-Content $path -ErrorAction SilentlyContinue
    }
    return @()
}

# Read versions
$serverVer = Get-VersionInfo $serverVerFile
$localVer  = Get-VersionInfo $localVerFile

# Show versions
Write-Host "=== Update Check ===" -ForegroundColor Cyan
Write-Host "Current version:" -NoNewline
Write-Host ($localVer -join "`n") -ForegroundColor Green

# Compare and show changelog
if ($serverVer -ne $null -and ($serverVer -join "`n") -ne ($localVer -join "`n")) {
    Write-Host "`nNew version available:" -ForegroundColor Yellow

    # Highlight new lines
    $newLines = $serverVer | Where-Object { $_ -notin $localVer }
    foreach ($line in $newLines) {
        Write-Host $line -ForegroundColor Magenta
    }
} else {
    Write-Host "`nYou are already up to date." -ForegroundColor Green
    exit
}

# Ask user if they want to continue
do {
    $choice = Read-Host "`nDo you want to continue with update? (y/n)"
} while ($choice -notmatch '^[ynYN]$')

if ($choice -match '^[nN]$') {
    Write-Host "Update cancelled." -ForegroundColor Red
    exit
}

# Remove everything except updater itself
Write-Host "`nCleaning current directory..." -ForegroundColor Cyan
Get-ChildItem -Path $PSScriptRoot -Force | ForEach-Object {
    if ($_.Name -notin @("do-update.ps1")) {
        Remove-Item $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# Copy all files from server to current dir
Write-Host "Copying new files..." -ForegroundColor Cyan
Copy-Item -Path (Join-Path $sourceDir "*") -Destination $PSScriptRoot -Recurse -Force

Write-Host "`nUpdate complete!" -ForegroundColor Green
