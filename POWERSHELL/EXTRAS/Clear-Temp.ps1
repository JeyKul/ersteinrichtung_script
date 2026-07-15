$TempPath = $env:TEMP
Write-Host "Cleaning temporary files in $TempPath..." -ForegroundColor Cyan
try {
    Get-ChildItem -Path $TempPath -File -Recurse -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue
    Get-ChildItem -Path $TempPath -Directory -Recurse -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Temporary files cleaned successfully!" -ForegroundColor Green
} catch {
    Write-Host "Some files could not be deleted: $_" -ForegroundColor Red
}
