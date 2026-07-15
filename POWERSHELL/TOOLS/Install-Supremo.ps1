# Set paths

Set-Location -Path $PSScriptRoot\..

$source = "..\EXE\Supremo.exe"
$targetDir = "C:\CT-T"
$targetExe = "$targetDir\Supremo.exe"
$shortcutPath = "C:\Users\Public\Desktop\CT-T Support.lnk"

# Create target directory if it doesn't exist
if (-not (Test-Path $targetDir)) {
    New-Item -Path $targetDir -ItemType Directory | Out-Null
}

. "$PSE\Download-Supremo.ps1"

# Create shortcut
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($shortcutPath)
$Shortcut.TargetPath = $targetExe
$Shortcut.WorkingDirectory = $targetDir
$Shortcut.WindowStyle = 1
$Shortcut.Description = "CT-T Remote Support"
$Shortcut.IconLocation = "$targetExe, 0"
$Shortcut.Save()

Write-Host "TeamViewerQS copied and shortcut created successfully." -ForegroundColor green