$ProgressPreference = 'SilentlyContinue'

$targetDir = "C:\CT-T"
$targetExe = "$targetDir\Supremo.exe"

if (-not (Test-Path "$targetDir\Supremo.exe")) {
    Invoke-WebRequest -Uri "https://www.ct-t.de/prog/Supremo.exe" -OutFile "$targetDir\Supremo.exe"
}



#& $targetDir\Supremo.exe