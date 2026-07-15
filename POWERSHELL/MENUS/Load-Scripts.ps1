# =============================================
# Shared loader for menu scripts
# File: POWERSHELL\MENUS\Load-Scripts.ps1
# =============================================

# === PATH SETUP ===
$script:PSM     = $PSScriptRoot
$script:PSD     = Split-Path -Parent $script:PSM
$script:rootDir = Split-Path -Parent $script:PSD
$script:exeDir  = Join-Path $script:rootDir 'EXE'

$script:PST     = Join-Path $script:PSD 'TOOLS'
$script:PSE     = Join-Path $script:PSD 'EXTRAS'
$script:PSEX    = Join-Path $script:PSD 'EXTERNAL'
$script:logRoot = Join-Path $script:rootDir 'Logs'

# === COLORS ===
$script:bgColor        = 'Black'
$script:menuColor      = 'DarkGray'
$script:titleColor     = 'Gray'
$script:highlightColor = 'White'

# === BASIC LOAD ===
. "$script:PST\Tool-Standby.ps1"
. "$script:PST\refresh-path.ps1"

# === MENU HELPERS ===
. "$script:PSM\Get-FitText.ps1"
. "$script:PSM\Get-SystemStatus.ps1"
. "$script:PSM\Show-Logo.ps1"
. "$script:PSM\Show-StatusLine.ps1"
. "$script:PSM\Set-MenuConsoleSize.ps1"
. "$script:PSM\Handle-Step.ps1"
. "$script:PSM\Reset-MenuScreen.ps1"
. "$script:PSM\Test-Network.ps1"

# === OTHER ===
$script:arch = $env:PROCESSOR_ARCHITECTURE

# === GLOBAL STATE ===
if (-not $script:activeComputerName) {
    $script:activeComputerName = $env:COMPUTERNAME
}

if (-not $script:logFile) {
    $script:logFile = $null
}