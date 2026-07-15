if (Get-Command choco.exe -ErrorAction SilentlyContinue) {
    Write-Host "Chocolatey installed" -ForegroundColor Green
} else {
    Write-Host "Chocolatey not found. Running fallback installer..." -ForegroundColor Yellow
    . "$PST\Install-WinGet.ps1"
}

$apps = @(
    @{ Name = "VLC Media Player"; Id = "vlc"; Params = "" },
    @{ Name = "7-Zip Zstandard";  Id = "7zip-zstd"; Params = "" },
    @{ Name = "Mozilla Firefox";  Id = "firefox"; Params = '/l:de' }
)

foreach ($app in $apps) {
    Write-Host "Installing $($app.Name)..." -ForegroundColor Cyan
    
    $args = ""
    if ($app.Params -ne "") {
        $args = "--install-arguments='$($app.Params)'"
    }

    $result = choco install $($app.Id) $args -y
    if ($LASTEXITCODE -eq 0) {
        Write-Host "$($app.Name) installed successfully.`n" -ForegroundColor Green
    } else {
        Write-Host "Failed to install $($app.Name). Error details:" -ForegroundColor Red
        Write-Host $result -ForegroundColor DarkRed
        Write-Host ""
    }
}
