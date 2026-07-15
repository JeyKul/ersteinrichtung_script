function Get-FitText {
    param(
        [string]$Text,
        [int]$MaxLength
    )

    if ($Text.Length -le $MaxLength) { return $Text }
    if ($MaxLength -le 3) { return $Text.Substring(0, $MaxLength) }

    return $Text.Substring(0, $MaxLength - 3) + '...'
}