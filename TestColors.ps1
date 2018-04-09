Import-Module ".\Write-HostColor.psm1"

$test = '`dbDarkBlue`
    `cCyan`
    `yYellow`
    `drDarkRed`
    `rRed`
    `dmDarkMagenta`
    `dcDarkCyan`
    `wWhite`
    `gGreen`
    `dyDarkGray`
    `bBlue`
    `bkBlack`
    `dlDarkYellow`
    `gyGray`
    `dgDarkGreen`
    `mMagenta`'

Write-HostColor $test