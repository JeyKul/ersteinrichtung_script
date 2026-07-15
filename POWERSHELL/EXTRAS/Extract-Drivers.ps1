# Extract-Drivers.ps1
# Export drivers into <DriveLetter>:\extracted_drivers\<Model>\
# Get model name (cleaned up for folder name)
$model = (Get-WmiObject Win32_ComputerSystem).Model.Trim()
$model = $model -replace '\s+', '_' -replace '[^a-zA-Z0-9_-]', ''

# Ask for drive letter
$drive = Read-Host "Enter device letter (e.g. E)"
$targetDir = "$drive`:\extracted_drivers\$model"

# Ensure folder exists
if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
}

# Export drivers with DISM
Write-Host "Exporting drivers to $targetDir ..."
dism /online /export-driver /destination:$targetDir