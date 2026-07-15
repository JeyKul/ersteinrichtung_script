# get values
$cpu = (Get-CimInstance Win32_Processor).Name -join ', '
$memBytes = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum
$ramGB = [math]::Round($memBytes / 1GB)
$ramMB = [math]::Round($memBytes / 1MB)

# memory clock (may be multiple modules) - try ConfiguredClockSpeed, fall back to Speed if empty
$speeds = (Get-CimInstance Win32_PhysicalMemory | ForEach-Object {
    $_.ConfiguredClockSpeed -as [int] -or $_.Speed -as [int]
}) | Where-Object { $_ } | Select-Object -Unique
$speedText = if ($speeds) { $speeds -join ', ' } else { 'n/a' }

# print nicely
Write-Host @"
CPU:                $cpu

RAM:
Größe:              ${ramGB} GB (${ramMB} MB)
Geschwindigkeit:    ${speedText} MHz
"@
