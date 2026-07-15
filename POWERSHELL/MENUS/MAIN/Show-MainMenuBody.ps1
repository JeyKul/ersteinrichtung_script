function Show-MainMenuBody {
    Write-Host "---------------Ersteinrichtung---------------" -ForegroundColor $titleColor
    Write-Host "1.  [BATCH] Privatkunde (Führt 5, 6, 7, 9 und 10 aus)" -ForegroundColor $menuColor
    Write-Host "2.  [BATCH] Geschäftskunde (Führt 5, 6, 8, 9, 10 und 22 aus)" -ForegroundColor $menuColor
    Write-Host "---------------Kein Umbenennen---------------" -ForegroundColor $titleColor
    Write-Host "3.  [BATCH] Privatkunde (Führt 6, 7, 9 und 10 aus)" -ForegroundColor $menuColor
    Write-Host "4.  [BATCH] Geschäftskunde (Führt 6, 8, 9, 10 und 22 aus)" -ForegroundColor $menuColor
    Write-Host "---------------------------------------------" -ForegroundColor $titleColor
    Write-Host ""
    Write-Host "5.  Rechner umbenennen" -ForegroundColor $menuColor
    Write-Host "6.  Choco installieren/updaten" -ForegroundColor $menuColor
    Write-Host "7.  Supremo für Privatkunden installieren" -ForegroundColor $menuColor
    Write-Host "8.  TeamViewer und Supremo für Geschäftskunden installieren" -ForegroundColor $menuColor
    Write-Host "9.  Installiere Standardprogramme" -ForegroundColor $menuColor
    Write-Host "10. Nach Updates suchen (Windows 11)" -ForegroundColor $menuColor
    Write-Host "19. Sysprep Setup OOBE" -ForegroundColor $menuColor
    Write-Host "20. WhyNotWin11 -> logs" -ForegroundColor $menuColor
    Write-Host "21. Secureboot and Bitlocker test" -ForegroundColor $menuColor
    Write-Host "22. Disable Windows ads and personalized shit" -ForegroundColor $menuColor
    Write-Host "---------------Weitere Menüs------------------" -ForegroundColor $titleColor
    Write-Host "11. Tools" -ForegroundColor $menuColor
    Write-Host "12. Extras" -ForegroundColor $menuColor
    Write-Host "13. Bitlocker Menu" -ForegroundColor $menuColor
    Write-Host "---------------------------------------------" -ForegroundColor $titleColor
    Write-Host ""
    Write-Host "0. Beenden" -ForegroundColor $highlightColor
    Write-Host ""
}