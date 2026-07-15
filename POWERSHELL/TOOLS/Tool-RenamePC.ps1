param (
    [string]$NewName
)

if (-not $NewName) {
    $NewName = Read-Host "Enter the new computer name"
}

$currentName = $env:COMPUTERNAME

if ($currentName -eq $NewName) {
    Write-Host "The computer is already named '$NewName'." -ForegroundColor Yellow
} else {
    Rename-Computer -NewName $NewName -Force
}

# Output new name for capturing
return $NewName
