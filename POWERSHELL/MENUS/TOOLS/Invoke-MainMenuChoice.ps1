function Invoke-MainMenuChoice {
    param(
        [string]$Choice
    )

    switch ($Choice) {
        '4' {
            . "$PSE\Download-WinDirStat.ps1"
        }
        '5' {
            . "$PSE\Download-AIPS.ps1"
        }
        '6' {
            $confirm = Read-Host 'Are you sure? This will install LSB and System Update for Lenovo devices (y/n)'
            if ($confirm -match '^[Yy]$') {
                . "$PSE\Download-Lenovo.ps1"
            }
            else {
                Write-Host "Cancelled Lenovo installation." -ForegroundColor Red
                Start-Sleep -Seconds 2
            }
        }
        '7' {
            . "$PSE\Download-neofetch.ps1"
        }
        '8' {
            Start-Process "$exeDir\DELL"
        }
        '9' {
            . "$PST\CheckInstall-WindowsUpdates.ps1"
        }
        '10' {
            irm "https://christitus.com/win" | iex
        }
        '11' {
            . "$PSE\Download-PS7.ps1"
        }
        '12' {
            Get-ChildItem $env:TEMP -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
        }
        '0' {
            exit
        }
        default {
            Write-Host "Ungültige Auswahl. Bitte erneut versuchen." -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
}