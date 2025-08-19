$apps = @(
    @{ Name = "VLC Media Player"; Id = "VideoLAN.VLC" },
    @{ Name = "7-Zip Zstandard";  Id = "mcmilk.7zip-zstd" },
    @{ Name = "Mozilla Firefox";  Id = "Mozilla.Firefox" }
)

foreach ($app in $apps) {
    Write-Host "Installing $($app.Name)..." -ForegroundColor Cyan
    $result = winget install --id=$($app.Id) --accept-package-agreements --accept-source-agreements

    if ($LASTEXITCODE -eq 0) {
        Write-Host "$($app.Name) installed successfully.`n" -ForegroundColor Green
    } else {
        Write-Host "Failed to install $($app.Name). Error details:" -ForegroundColor Red
        Write-Host $result -ForegroundColor DarkRed
        Write-Host ""
    }
}

$programs = @{
    "VLC"         = "C:\Program Files (x86)\VideoLAN\VLC"
    "7-Zip-Zstd"  = "C:\Program Files\7-Zip-Zstandard"
    "Firefox"     = "C:\Program Files\Mozilla Firefox"
}

foreach ($prog in $programs.GetEnumerator()) {
    $name = $prog.Key
    $path = $prog.Value

    if (Test-Path $path) {
        $status = "$name is installed."
    } else {
        $status = "$name is NOT installed."
    }

    # Call your logging script with the status message
    log $status
}
