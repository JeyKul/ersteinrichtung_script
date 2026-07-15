function Install-WinUtilChoco {

    <#
    .SYNOPSIS
        Ensures Chocolatey is installed and up to date.
        If C:\ProgramData\Chocolatey\bin\choco.exe exists, upgrades Chocolatey.
        Otherwise, runs the official install command.
    #>

    $chocoPath = Join-Path $env:ProgramData 'chocolatey\bin\choco.exe'

    try {
        if (Test-Path -Path $chocoPath) {
            Write-Host "Chocolatey found at $chocoPath. Upgrading Chocolatey..."
            & $chocoPath upgrade chocolatey -y
        }
        else {
            Write-Host "Chocolatey not found. Installing Chocolatey..."
            Set-ExecutionPolicy Bypass -Scope Process -Force
            [System.Net.ServicePointManager]::SecurityProtocol = `
                [System.Net.ServicePointManager]::SecurityProtocol -bor 3072

            $installScript = 'https://community.chocolatey.org/install.ps1'
            Invoke-Expression (
                (New-Object System.Net.WebClient).DownloadString($installScript)
            )

            # After install, ensure Chocolatey is on PATH and upgrade once
            $chocoPath = Join-Path $env:ProgramData 'chocolatey\bin\choco.exe'
            if (Test-Path -Path $chocoPath) {
                refresh-path
                Write-Host "Chocolatey installed successfully. Upgrading Chocolatey..."
                & $chocoPath upgrade chocolatey -y
            }
            else {
                throw "Chocolatey installation completed but choco.exe not found at expected path: $chocoPath"
            }
        }
    }
    catch {
        Write-Host "===========================================" -ForegroundColor Red
        Write-Host "--   Chocolatey failed to install/upgrade  --" -ForegroundColor Red
        Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "===========================================" -ForegroundColor Red
    }
}