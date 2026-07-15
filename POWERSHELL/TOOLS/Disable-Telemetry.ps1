# =======================
# Disable telemetry block
# =======================

echo ("`n" * $Host.UI.RawUI.WindowSize.Height)
$e = [char]27
echo "$e[H" # Move cursor to 0;0
echo "$e[J" # Erase down/right

Write-Host ""
Write-Host "=== Telemetry / privacy tweaks ==="
Start-Sleep -Seconds 2
# Helper: ensure key exists
function Ensure-Key {
    param(
        [string]$Path
    )
    if (-not (Test-Path $Path)) {
        New-Item -Path $Path -Force | Out-Null
    }
}

# Registry tweaks (HKCU + HKLM)
$regItems = @(
    @{ Path = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo';                Name = 'Enabled';                                   Value = 0; Type = 'DWord' }
    @{ Path = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy';                       Name = 'TailoredExperiencesWithDiagnosticDataEnabled'; Value = 0; Type = 'DWord' }
    @{ Path = 'HKCU:\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy';          Name = 'HasAccepted';                               Value = 0; Type = 'DWord' }
    @{ Path = 'HKCU:\Software\Microsoft\Input\TIPC';                                           Name = 'Enabled';                                   Value = 0; Type = 'DWord' }
    @{ Path = 'HKCU:\Software\Microsoft\InputPersonalization';                                Name = 'RestrictImplicitInkCollection';            Value = 1; Type = 'DWord' }
    @{ Path = 'HKCU:\Software\Microsoft\InputPersonalization';                                Name = 'RestrictImplicitTextCollection';           Value = 1; Type = 'DWord' }
    @{ Path = 'HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore';               Name = 'HarvestContacts';                          Value = 0; Type = 'DWord' }
    @{ Path = 'HKCU:\Software\Microsoft\Personalization\Settings';                            Name = 'AcceptedPrivacyPolicy';                    Value = 0; Type = 'DWord' }
    @{ Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection';       Name = 'AllowTelemetry';                           Value = 0; Type = 'DWord' }  # Enterprise-only respects 0[web:78]
    @{ Path = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced';            Name = 'Start_TrackProgs';                         Value = 0; Type = 'DWord' }
    @{ Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System';                             Name = 'PublishUserActivities';                    Value = 0; Type = 'DWord' }
    @{ Path = 'HKCU:\Software\Microsoft\Siuf\Rules';                                          Name = 'NumberOfSIUFInPeriod';                     Value = 0; Type = 'DWord' }
)

foreach ($item in $regItems) {
    Ensure-Key -Path $item.Path
    New-ItemProperty -Path $item.Path -Name $item.Name -Value $item.Value -PropertyType $item.Type -Force | Out-Null
    Write-Host "Disabling $($item.Path)\$($item.Name) with $($item.Value) in $($item.Type)..."
    Start-Sleep -Seconds 1
}

# Script part: Defender, services, error reporting
try {
    # Disable Defender Auto Sample Submission (2 = Never send)[web:72]
    Set-MpPreference -SubmitSamplesConsent 2 -ErrorAction SilentlyContinue
}
catch {
    Write-Host "Could not change Defender sample submission (permission / product?)" -ForegroundColor Yellow
}

# Disable Connected User Experiences and Telemetry (DiagTrack) service[web:73][web:79]
try {
    Set-Service -Name 'DiagTrack' -StartupType Disabled -ErrorAction SilentlyContinue
}
catch {
    Write-Host "Could not change DiagTrack service" -ForegroundColor Yellow
}

# Disable Windows Error Reporting service (wermgr)[web:79]
try {
    Set-Service -Name 'WerSvc' -StartupType Disabled -ErrorAction SilentlyContinue
}
catch {
    Write-Host "Could not change Windows Error Reporting service" -ForegroundColor Yellow
}

# Match Svchost split threshold to physical memory (as in your snippet)
try {
    $MemoryKB = (Get-CimInstance Win32_PhysicalMemory | Measure-Object Capacity -Sum).Sum / 1KB
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control' -Name 'SvcHostSplitThresholdInKB' -Value $MemoryKB -Type DWord -ErrorAction SilentlyContinue
}
catch {
    Write-Host "Could not set SvcHostSplitThresholdInKB" -ForegroundColor Yellow
}

# Remove PeriodInNanoSeconds if it exists
try {
    if (Test-Path 'HKCU:\Software\Microsoft\Siuf\Rules') {
        Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Siuf\Rules' -Name 'PeriodInNanoSeconds' -ErrorAction SilentlyContinue
    }
}
catch {
    # ignore
}

Write-Host "Telemetry tweaks applied." -ForegroundColor Green
pause