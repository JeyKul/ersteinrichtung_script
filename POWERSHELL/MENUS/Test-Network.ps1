function Show-OfflineWarning {
    $raw = $Host.UI.RawUI
    $origFg = $raw.ForegroundColor
    $origBg = $raw.BackgroundColor

    $msg = "You're not connected to the Internet. Most functions will not work."
    $width = $raw.WindowSize.Width
    $leftPad = [math]::Max(0, [int](($width - $msg.Length) / 2))
    $line = (' ' * $leftPad) + $msg

    Reset-MenuScreen
    $raw.ForegroundColor = 'Yellow'
    $raw.BackgroundColor = 'DarkRed'
    Write-Host ""
    Write-Host $line
    Write-Host ""

    Start-Sleep -Seconds 4

    $raw.ForegroundColor = $origFg
    $raw.BackgroundColor = $origBg
    Reset-MenuScreen
}

function Test-InternetConnection {
    try {
        Test-NetConnection -ComputerName '8.8.8.8' -InformationLevel Quiet -WarningAction SilentlyContinue -ErrorAction SilentlyContinue
    }
    catch {
        $false
    }
}