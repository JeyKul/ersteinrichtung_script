# Clear-WindowsCache.ps1
# PowerShell script to clean various Windows cache directories

# Run as Administrator
Log ("Disable Hibernation to clean Pagefile and hiberfil")
Start-Process -FilePath "powercfg" -ArgumentList "-h off" -NoNewWindow -Wait

# Function to delete files and folders
function Clear-CachePath {
    param (
        [string]$Path
    )
    if (Test-Path $Path) {
        try {
            Remove-Item -Path $Path -Recurse -Force -ErrorAction Stop
            Write-Host "Cleared: $Path" -ForegroundColor Green
        } catch {
            Write-Host "Failed to clear: $Path`nError: $_" -ForegroundColor Yellow
        }
    } else {
        Write-Host "Path not found: $Path" -ForegroundColor Gray
    }
}

# List of cache paths to clear
$cachePaths = @(
    # Standard Windows Temp
    "$env:TEMP",
    "$env:WINDIR\Temp",
    "$env:LOCALAPPDATA\Temp",

    # Windows Explorer & Icon Cache
    "$env:LOCALAPPDATA\IconCache.db",
    "$env:USERPROFILE\AppData\Local\IconCache.db",

    # Windows Cache
    "$env:LOCALAPPDATA\Microsoft\Windows\WebCache",
    "$env:LOCALAPPDATA\Microsoft\Windows\Notifications",
    "$env:LOCALAPPDATA\Microsoft\Windows\DeliveryOptimization",
    "$env:LOCALAPPDATA\Microsoft\Windows\Caches",

    # Prefetch & Update
    "$env:WINDIR\Prefetch",
    "$env:WINDIR\SoftwareDistribution\Download",
    "$env:SYSTEMDRIVE\ProgramData\Microsoft\Windows\WER",
    "$env:ProgramData\Microsoft\Windows\DeliveryOptimization\Cache",

    # UWP/Store App Cache
    "$env:LOCALAPPDATA\Packages\*\AC\Temp",
    "$env:LOCALAPPDATA\Packages\*\LocalCache",
    "$env:LOCALAPPDATA\Packages\*\TempState",
    "$env:LOCALAPPDATA\Packages\*\AC\INetCache",

    # Chrome Cache
    "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache",
    "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Code Cache",
    "$env:LOCALAPPDATA\Google\Chrome\User Data\ShaderCache",

    # Edge Cache
    "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache",
    "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Code Cache",
    "$env:LOCALAPPDATA\Microsoft\Edge\User Data\ShaderCache",
    "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Service Worker\CacheStorage",

    # Firefox Cache
    "$env:APPDATA\Mozilla\Firefox\Profiles\*\cache2",
    "$env:APPDATA\Mozilla\Firefox\Profiles\*\thumbnails",
    "$env:APPDATA\Mozilla\Firefox\Profiles\*\startupCache",

    # Teams Cache
    "$env:APPDATA\Microsoft\Teams\Service Worker\CacheStorage",
    "$env:APPDATA\Microsoft\Teams\Cache",
    "$env:APPDATA\Microsoft\Teams\blob_storage",
    "$env:APPDATA\Microsoft\Teams\GPUCache",

    # OneDrive Logs
    "$env:LOCALAPPDATA\Microsoft\OneDrive\logs",

    # Browsers (More)
    "$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data\Default\Cache",
    "$env:LOCALAPPDATA\Vivaldi\User Data\Default\Cache",

    # Media Apps
    "$env:APPDATA\vlc",
    "$env:APPDATA\Roaming\Adobe\Common\Media Cache Files",
    "$env:APPDATA\AppData\Roaming\Adobe\Adobe Photoshop*\Logs",

    # Chat / Social Apps
    "$env:APPDATA\Slack\Cache",
    "$env:APPDATA\Slack\Code Cache",
    "$env:APPDATA\Discord\Cache",
    "$env:APPDATA\Discord\Code Cache",
    "$env:APPDATA\Discord\GPUCache",

    # Epic Games Launcher
    "$env:LOCALAPPDATA\EpicGamesLauncher\Saved\webcache",
    "$env:LOCALAPPDATA\EpicGamesLauncher\Saved\webcache_4147",
    "$env:LOCALAPPDATA\EpicGamesLauncher\Saved\webcache_4430",

    # Steam
    "$env:LOCALAPPDATA\Steam\htmlcache",
    "$env:LOCALAPPDATA\Steam\shadercache",

    # Game Dev / Editor / Graphics
    "$env:LOCALAPPDATA\AMD\DxCache",
    "$env:LOCALAPPDATA\Intel\GfxCPL",
    "$env:LOCALAPPDATA\D3DSCache",

    # Office / OneNote / Outlook
    "$env:LOCALAPPDATA\Microsoft\OneNote\16.0\cache",

    # Crash Dumps / Logs
    "$env:LOCALAPPDATA\CrashDumps",
    "$env:ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger"
)


# Execute cleanup
Log ("Cleaning cache folders...")
foreach ($path in $cachePaths) {
    Clear-CachePath -Path $path
}

Log ("All specified cache locations have been processed.")
Log ("Re-Enable Hibernation to clean Pagefile and hiberfil ")
Start-Process -FilePath "powercfg" -ArgumentList "-h on" -NoNewWindow -Wait