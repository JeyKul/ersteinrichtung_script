# Run this as Administrator!

Write-Host "=== Windows Edition Downgrade Script ===" -ForegroundColor Cyan

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"

try {
    # Optional: show current values before changing
    Write-Host "`nCurrent values:"
    Get-ItemProperty -Path $regPath | Select-Object ProductName, EditionID | Format-List

    # Update EditionID and ProductName
    Set-ItemProperty -Path $regPath -Name "EditionID" -Value "Professional"
    Set-ItemProperty -Path $regPath -Name "ProductName" -Value "Windows 10 Pro"

    Write-Host "`nUpdated registry successfully!" -ForegroundColor Green
    Write-Host "EditionID -> Professional"
    Write-Host "ProductName -> Windows 10 Pro"
}
catch {
    Write-Host "Error while updating registry: $_" -ForegroundColor Red
}

Write-Host "`nNext steps:"
Write-Host "1. Run Windows setup with Pro media (same or newer build)."
Write-Host "2. Choose 'Keep files and apps'."
Write-Host "3. Enter a valid Windows Pro key when prompted."
