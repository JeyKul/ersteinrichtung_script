function Invoke-MainMenuChoice {
    param(
        [string]$Choice
    )

    switch ($Choice) {
        '1' {
            DSSS
            Handle-Step '5'
            foreach ($step in '6','7','9','10') { Handle-Step $step }
            RSSS
        }
        '2' {
            DSSS
            Handle-Step '5'
            foreach ($step in '6','8','9','10','22') { Handle-Step $step }
            RSSS
        }
        '3' {
            DSSS
            foreach ($step in '6','7','9','10') { Handle-Step $step }
            RSSS
        }
        '4' {
            DSSS
            foreach ($step in '6','8','9','10','22') { Handle-Step $step }
            RSSS
        }
        '5'   { Handle-Step '5' }
        '6'   { Handle-Step '6' }
        '7'   { Handle-Step '7' }
        '8'   { Handle-Step '8' }
        '9'   { DSSS; Handle-Step '9'; RSSS }
        '10'  { DSSS; Handle-Step '10' }
        '11'  { Handle-Step '11' }
        '12'  { Handle-Step '12' }
        '13'  { Handle-Step '13' }
        '19'  { Handle-Step '19' }
        '20'  { Handle-Step '20' }
        '21'  { Handle-Step '21' }
        '22'  { Handle-Step '22' }
        '30'  { Handle-Step '30' }
        '31'  { Handle-Step '31' }
        '399' { Handle-Step '399' }
        '398' { Handle-Step '398' }
        '51'  { Handle-Step '51' }
        '52'  { Handle-Step '52' }
        '0' {
            Log "Script finished at $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
            exit
        }
        default {
            Write-Host "Invalid selection. Try again." -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
}