function Get-SystemStatus {
    $PCName     = (Get-CimInstance -ClassName Win32_ComputerSystem -Property Name).Name
    $secureBoot = if (Confirm-SecureBootUEFI) { '✓' } else { '✗' }
    $bitlocker  = if ((Get-BitLockerVolume -MountPoint 'C:').ProtectionStatus -eq 'On') { '✓' } else { '✗' }
    $cpu        = (Get-CimInstance Win32_Processor).Name
    $ramGB      = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 1)

    $chocoPath = 'C:\ProgramData\chocolatey\bin\choco.exe'
    $choco     = if (Test-Path $chocoPath) { '✓' } else { '✗' }

    [pscustomobject]@{
        SecureBoot      = $secureBoot
        BitLocker       = $bitlocker
        CPU             = $cpu
        RAMGB           = $ramGB
        Choco           = $choco
        PCName          = $PCName
        SecureBootColor = if ($secureBoot -eq '✓') { 'Green' } else { 'Red' }
        BitLockerColor  = if ($bitlocker  -eq '✓') { 'Green' } else { 'Red' }
        ChocoColor      = if ($choco -eq '✓') { 'Green' } else { 'Red' }
    }
}