echo ("`n" * $Host.UI.RawUI.WindowSize.Height)
$e = [char]27
echo "$e[H" # Move cursor to 0;0
echo "$e[J" # Erase down/right

$fgOk  = 'Green'
$fgBad = 'Red'

Write-Host "=== System Check ==="
Write-Host ""

# Check BitLocker (C:)
try {
    $blv = Get-BitLockerVolume -MountPoint 'C:' -ErrorAction Stop
    if ($blv.ProtectionStatus -eq 1) {
        Write-Host "BitLocker: ON  (C: protected)" -ForegroundColor $fgOk
    } else {
        Write-Host "BitLocker: OFF (C: not protected)" -ForegroundColor $fgBad
    }
}
catch {
    Write-Host "BitLocker: Not available or not installed" -ForegroundColor $fgBad
}

# Check Secure Boot
try {
    $sb = Confirm-SecureBootUEFI -ErrorAction Stop
    if ($sb) {
        Write-Host "Secure Boot: ON" -ForegroundColor $fgOk
    } else {
        Write-Host "Secure Boot: OFF" -ForegroundColor $fgBad
    }
}
catch {
    Write-Host "Secure Boot: Not supported / cannot be queried" -ForegroundColor $fgBad
}

Write-Host ""
Pause
