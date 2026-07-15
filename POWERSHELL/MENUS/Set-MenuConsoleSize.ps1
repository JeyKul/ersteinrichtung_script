function Set-MenuConsoleSize {
    param(
        [int]$Width = 140,
        [int]$Height = 45,
        [int]$BufferHeight = 3000
    )

    if ($Host.Name -ne 'ConsoleHost') {
        return
    }

    $raw = $Host.UI.RawUI
    $max = $raw.Get_MaxWindowSize()

    $targetWidth  = [math]::Min($Width,  $max.Width)
    $targetHeight = [math]::Min($Height, $max.Height)

    $buffer = $raw.BufferSize
    $window = $raw.WindowSize

    $isGrowingWidth  = $targetWidth  -gt $window.Width
    $isGrowingHeight = $targetHeight -gt $window.Height

    if ($isGrowingWidth -or $isGrowingHeight) {
        if ($buffer.Width -lt $targetWidth) { $buffer.Width = $targetWidth }
        if ($buffer.Height -lt $BufferHeight) { $buffer.Height = $BufferHeight }
        $raw.Set_BufferSize($buffer)

        $window.Width  = $targetWidth
        $window.Height = $targetHeight
        $raw.Set_WindowSize($window)
    }
    else {
        $window.Width  = $targetWidth
        $window.Height = $targetHeight
        $raw.Set_WindowSize($window)

        if ($buffer.Width -lt $targetWidth) { $buffer.Width = $targetWidth }
        if ($buffer.Height -lt $targetHeight) { $buffer.Height = $targetHeight }
        $raw.Set_BufferSize($buffer)
    }
}