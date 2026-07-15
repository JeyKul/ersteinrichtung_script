function Show-StatusLine {
    param(
        [Parameter(Mandatory)]
        $Status
    )

    $windowWidth = $Host.UI.RawUI.WindowSize.Width
    $baseText = "SecureBoot: $($Status.SecureBoot) | BitLocker: $($Status.BitLocker) | CPU:  | RAM: $($Status.RAMGB) GB"
    $availableCpuChars = $windowWidth - $baseText.Length - 2

    if ($availableCpuChars -lt 12) {
        $availableCpuChars = 12
    }

    $cpuText = Get-FitText -Text $Status.CPU -MaxLength $availableCpuChars

    Write-Host -NoNewline "SecureBoot: " -ForegroundColor $Status.SecureBootColor
    Write-Host -NoNewline $Status.SecureBoot -ForegroundColor $Status.SecureBootColor
    Write-Host -NoNewline " | "

    Write-Host -NoNewline "BitLocker: " -ForegroundColor $Status.BitLockerColor
    Write-Host -NoNewline $Status.BitLocker -ForegroundColor $Status.BitLockerColor
    Write-Host -NoNewline " | "

    Write-Host -NoNewline "Choco: " -ForegroundColor $Status.ChocoColor
    Write-Host -NoNewline $Status.Choco -ForegroundColor $Status.ChocoColor
    Write-Host -NoNewline " | "

    Write-Host -NoNewline "PC Name: $($Status.PCName)"
    Write-Host ""
    Write-Host ""

    Write-Host -NoNewline "CPU: $cpuText | "
    Write-Host -NoNewline "RAM: $($Status.RAMGB) GB"
    Write-Host ""
}