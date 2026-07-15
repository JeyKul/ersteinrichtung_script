Write-Host "Disabling FastBoot" -ForegroundColor Green
powercfg.exe /h off

function DSSS {
    Write-Host "Disabling Standby" -ForegroundColor Green
    powercfg.exe -change -standby-timeout-ac 0
    powercfg.exe -change -standby-timeout-dc 0
    powercfg.exe -change -hibernate-timeout-ac 0
    powercfg.exe -change -hibernate-timeout-dc 0
    powercfg.exe -change -monitor-timeout-ac 0
    powercfg.exe -change -monitor-timeout-dc 0
}

function RSSS {
    Write-Host "Revert Standby" -ForegroundColor Green
    powercfg.exe -change -standby-timeout-ac 30
    powercfg.exe -change -standby-timeout-dc 15
    powercfg.exe -change -hibernate-timeout-ac 180
    powercfg.exe -change -hibernate-timeout-dc 60
    powercfg.exe -change -monitor-timeout-ac 10
    powercfg.exe -change -monitor-timeout-dc 5
}