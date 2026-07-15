# Go up one directory
# Detect system architecture
$arch = $env:PROCESSOR_ARCHITECTURE

if ($arch -eq "AMD64") {
    $exe = "$PST\NXTUpdateManager_AMD64.exe"
}
elseif ($arch -eq "ARM64") {
    $exe = "$PST\NXTUpdateManager_ARM64.exe"
}
else {
    Write-Error "Unsupported architecture: $arch"
    exit 1
}

# Run the updater twice with a delay
& $exe -s -v -r -p
Start-Sleep -Seconds 3
& $exe -s -v -r -p
RSSS 