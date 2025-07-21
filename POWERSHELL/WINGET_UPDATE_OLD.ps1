#Requires -RunAsAdministrator
<#
.SYNOPSIS
Installs/updates Winget using specified Microsoft.UI.Xaml NuGet package and Winget MSIX bundle
#>

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Create temporary directory with timestamp
$tempDir = Join-Path $env:TEMP "winget-install-$(Get-Date -Format 'yyyyMMddHHmmss')"
New-Item -ItemType Directory -Path $tempDir -Force | Out-Null
$ProgressPreference = 'SilentlyContinue'

try {
    # Download and process Microsoft.UI.Xaml NuGet package
    $nugetUrl = "https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.8.7"
    $nupkgPath = Join-Path $tempDir "Microsoft.UI.Xaml.2.8.7.nuget"
    $nupkgZIP = Join-Path $tempDir "Microsoft.UI.Xaml.2.8.7.zip"

    Write-Host "Downloading Microsoft.UI.Xaml 2.8.7..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri $nugetUrl -OutFile $nupkgPath -UseBasicParsing
    Rename-Item $nupkgPath $nupkgZIP

    # Extract NuGet package
    $extractDir = Join-Path $tempDir "Microsoft.UI.Xaml"
    Expand-Archive -Path $nupkgZIP -DestinationPath $extractDir -Force

$arch = (Get-CimInstance Win32_OperatingSystem).OSArchitecture

$archShort = switch -Wildcard ($arch) {
    "*ARM*64*"  { "arm64"; break }
    "*ARM*"     { "arm"; break }
    "*64-bit*"  { "x64"; break }
    "*32-bit*"  { "x86"; break }
    default     { "unknown" }
}

$archShort


    $xamlAppxPath = Join-Path $extractDir "tools\AppX\$archShort\Release\Microsoft.UI.Xaml.2.8.appx"
    if (-not (Test-Path $xamlAppxPath)) {
        throw "Microsoft.UI.Xaml.2.8.appx not found."
    }

    Write-Host "Installing Microsoft.UI.Xaml 2.8..." -ForegroundColor Cyan
    Add-AppxPackage -Path $xamlAppxPath -ErrorAction Stop

    # Download Winget bundle
    $wingetUrl = "https://aka.ms/getwinget"
    $wingetTempPath = Join-Path $tempDir "winget_download"
    Write-Host "Downloading Winget..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri $wingetUrl -OutFile $wingetTempPath -UseBasicParsing

    # Rename to .msixbundle if not already
    if (-not ($wingetTempPath -like "*.msixbundle")) {
        $renamedPath = Join-Path $tempDir "Microsoft.DesktopAppInstaller.msixbundle"
        Rename-Item -Path $wingetTempPath -NewName (Split-Path $renamedPath -Leaf)
        $wingetPath = $renamedPath
    } else {
        $wingetPath = $wingetTempPath
    }

    # Verify the file exists
    if (-not (Test-Path $wingetPath)) {
        # Try to find any .msixbundle
        $wingetPath = Get-ChildItem -Path $tempDir -Filter "*.msixbundle" | Select-Object -ExpandProperty FullName -First 1
    }

    if ($wingetPath) {
        Write-Host "Installing Winget from $([System.IO.Path]::GetFileName($wingetPath))..." -ForegroundColor Cyan
        Add-AppxPackage -Path $wingetPath -ErrorAction Stop
    } else {
        throw "Winget .msixbundle not found after download."
    }

    # Verify installation
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "Winget installed/updated successfully!" -ForegroundColor Green
        Write-Host "Version: $(winget --version)"
    } else {
        Write-Host "Installation completed but 'winget' command not found." -ForegroundColor Yellow
        Write-Host "Try restarting your terminal or computer." -ForegroundColor Yellow
    }
}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
    pause
    exit 1
}
finally {
    if (Test-Path $tempDir) {
        Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue
    }
}
