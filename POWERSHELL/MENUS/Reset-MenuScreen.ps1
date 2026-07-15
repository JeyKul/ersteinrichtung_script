function Reset-MenuScreen {
    try {
        $raw = $Host.UI.RawUI
        $space = New-Object System.Management.Automation.Host.BufferCell
        $space.Character = ' '
        $space.ForegroundColor = $raw.ForegroundColor
        $space.BackgroundColor = $raw.BackgroundColor
        $space.BufferCellType = [System.Management.Automation.Host.BufferCellType]::Complete

        $rect = New-Object System.Management.Automation.Host.Rectangle
        $rect.Left = 0
        $rect.Top = 0
        $rect.Right = $raw.BufferSize.Width - 1
        $rect.Bottom = $raw.WindowSize.Height - 1

        $raw.SetBufferContents($rect, $space)
        $raw.CursorPosition = [System.Management.Automation.Host.Coordinates]::new(0,0)
    }
    catch {
        try { [System.Console]::Clear() } catch {}
        try { Clear-Host } catch {}
    }
}