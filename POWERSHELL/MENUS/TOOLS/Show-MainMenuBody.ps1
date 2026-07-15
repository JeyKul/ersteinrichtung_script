function Show-MainMenuBody {
    Write-Host "---------------------TOOLS---------------------" -ForegroundColor $titleColor
    Write-Host "4.  WinDirStat" -ForegroundColor $menuColor
    Write-Host "5.  AdvancedIPScanner" -ForegroundColor $menuColor
    Write-Host "6.  Lenovo Treiber sachen" -ForegroundColor $menuColor
    Write-Host "7.  System Informationen" -ForegroundColor $menuColor
    Write-Host "8.  DELL Treiber sachen" -ForegroundColor $menuColor
    Write-Host "9.  Nach Updates suchen (Windows 11)" -ForegroundColor $menuColor
    Write-Host "10. Chris Titus Script" -ForegroundColor $menuColor
    Write-Host "11. Install Powershell 7" -ForegroundColor $menuColor

    $filesToCheck = @(
        "$env:TEMP\LSBSetup.exe",
        "$env:TEMP\system_update_5.08.03.59.exe",
        "$env:TEMP\Advanced_IP_Scanner_2.5.4594.1.exe",
        "$env:TEMP\WinDirStat.zip"
    )

    if ($filesToCheck | Where-Object { Test-Path $_ }) {
        Write-Host "12. Clear TEMP (recommended)" -ForegroundColor $highlightColor
    }
    else {
        Write-Host "12. Clear TEMP" -ForegroundColor $menuColor
    }

    Write-Host "-----------------------------------------------" -ForegroundColor $titleColor
    Write-Host "0. Beenden" -ForegroundColor $highlightColor
    Write-Host ""
}