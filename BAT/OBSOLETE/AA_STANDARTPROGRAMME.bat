@echo off
echo Installing standard applications...
echo ---------------------------------

winget install VideoLAN.VLC --silent --accept-package-agreements --accept-source-agreements
if %ERRORLEVEL% neq 0 (
    echo Failed to install VLC
    exit /b 1
)

winget install mcmilk.7Zip-zstd --silent --accept-package-agreements --accept-source-agreements
if %ERRORLEVEL% neq 0 (
    echo Failed to install mcmilk.7Zip-zstd
    exit /b 1
)

winget install Mozilla.Firefox --silent --accept-package-agreements --accept-source-agreements
if %ERRORLEVEL% neq 0 (
    echo Failed to install Firefox
    exit /b 1
)

echo All applications installed successfully
exit /b 0