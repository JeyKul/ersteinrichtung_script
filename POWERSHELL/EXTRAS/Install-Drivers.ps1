# Install-Drivers.ps1
# Install drivers from <DriveLetter>:\extracted_drivers\<Model>\

# Get model name (same cleaning as in Extract script)
$model = (Get-WmiObject Win32_ComputerSystem).Model.Trim()
$model = $model -replace '\s+', '_' -replace '[^a-zA-Z0-9_-]', ''

# Ask for drive letter
$drive = Read-Host "Enter device letter (e.g. E)"
$driverPath = "$drive`:\extracted_drivers\$model"

# Check if path exists
if (-not (Test-Path $driverPath)) {
    Write-Error "Driver path '$driverPath' does not exist. Aborting."
    exit 1
}

# Install drivers
Write-Host "Installing drivers from $driverPath ..."
pnputil /add-driver "$driverPath\*.inf" /subdirs /install
