function Handle-Step {
    param(
        [string]$Step
    )

    try {
        switch ($Step) {
            '5' {
                Log "[STEP 5] Computer umbenennen"
                $newName = . "$PST\Tool-RenamePC.ps1"
                if ($newName) {
                    $script:activeComputerName = $newName
                    Init-Logging
                    Log "Computer renamed to '$newName'."
                }
                else {
                    Log "Rename script did not return a new name."
                }
            }
            '6' {
                Log "[STEP 6] Choco install/update"
                . "$PSEX\Install-WinUtilChoco.ps1"
                Install-WinUtilChoco
            }
            '7' {
                Log "[STEP 7] Supremo install"
                . "$PST\Install-Supremo.ps1"
            }
            '8' {
                Log "[STEP 8] Teamviewer GK & Supremo install"
                . "$PST\Install-TeamviewerGK_Supremo.ps1"
            }
            '9' {
                Log "[STEP 9] Standartprogramme"
                . "$PST\Install-DefaultPrograms.ps1"

                $programs = @{
                    'VLC'          = 'C:\Program Files\VideoLAN\VLC'
                    '7-Zip-Zstd'   = 'C:\Program Files\7-Zip-Zstandard'
                    'TeamViewerGK' = 'C:\Program Files (x86)\TeamViewer'
                    'TeamViewerPK' = 'C:\CT-T'
                    'Firefox'      = 'C:\Program Files\Mozilla Firefox'
                }

                foreach ($prog in $programs.GetEnumerator()) {
                    if (Test-Path $prog.Value) {
                        Log "[CHECK_PROGRAMS] $($prog.Key) is installed."
                    }
                    else {
                        Log "[CHECK_PROGRAMS] $($prog.Key) is NOT installed."
                    }
                }
            }
            '10' {
                Log "[STEP 10] Windows update check"
                . "$PST\CheckInstall-WindowsUpdates.ps1"
            }
            '11' {
                Log "[Choice 11] Open Tools menu."
                & "$PSD\Menu-Tools.ps1"
            }
            '12' {
                Log "[Choice 12] Open Extras menu."
                . "$PSD\Menu-Extra.ps1"
            }
            '13' {
                Log "[Choice 13] Open Bitlocker menu."
                . "$PSD\Menu-Bitlocker.ps1"
            }
            '19' {
                $unattend = Join-Path $PSD 'unattend.xml'
                & "$env:windir\System32\Sysprep\sysprep.exe" /oobe /reboot /unattend:$unattend
            }
            '20' {
                Log "[Choice 20] Check Windows 11 Compability."
                . "$PSE\Download-WhyNoW11.ps1"
                & "$env:TEMP\WhyNotWin11.exe" /e txt "$logRoot\$($env:COMPUTERNAME).whynotwin11.txt" /f /silent
            }
            '21' {
                Log "[Choice 21] Check Bitlocker and Secureboot."
                . "$PST\IsSecureboot_Bitlocker-true.ps1"
            }
            '22' {
                Log "[Choice 22] Disable Windows ads and personalized shit"
                . "$PST\Disable-Telemetry.ps1"
            }
            '30' {
                Log "[LTSC][Choice 30] Install Windows Store"
                powershell.exe -command "wsreset -i"
                powershell.exe -command "sleep 12"
            }
            '31' {
                Log "[LTSC][Choice 31] Install App-Installer (Winget)"
                powershell.exe -command "start ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1"
            }
            '51' {
                . "$PSscriptPath\Extract-Drivers.ps1"
            }
            '52' {
                . "$PSscriptPath\Install-Drivers.ps1"
            }
            '399' {
                Log "[LTSC to Pro]"
                . "$PSscriptPath\Enable-LTSCUpgradePath.ps1"
            }
            '398' {
                Log "[Office Removal]"
                iwr https://get.admon.me/remove-msoffice -OutFile msoffice-removal-tool.ps1
                powershell -ExecutionPolicy Bypass .\msoffice-removal-tool.ps1
            }
            default {
                Log "[UNKNOWN STEP] $Step"
            }
        }
    }
    catch {
        Log "ERROR in step ${Step}: $_"
    }
}