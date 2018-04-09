
Function Write-HostColor
{
    <#
    .SYNOPSIS

    Add multiple colors to strings with ease

    .DESCRIPTION

    Adds color to the Write-Host command by following a specific string format.
    Example: Write-HostColor '`rThis is red` this is default `yThis is yellow`'.

    .PARAMETER String
    String will be 'Write-Host' to command line with colors

    .INPUTS

    None. You cannot pipe objects to Add-Extension.

    .OUTPUTS

    None.

    .EXAMPLE

    C:\PS> Write-HostColor '`rThis is red` this is default `yThis is yellow`'.


    .LINK

    http://www.github.com/rascoro1/write-hostcolor

    .LINK

    Set-Item
    #>

    Param(
        $String 
    )
    
    $COLOR_MAPPING = @{
     "bk" = "Black" 
     "db" = "DarkBlue" 
     "dg" = "DarkGreen" 
     "dc" = "DarkCyan" 
     "dr" = "DarkRed" 
     "dm" = "DarkMagenta" 
     "dl" = "DarkYellow" 
     "gy" = "Gray" 
     "dy" = "DarkGray" 
     "b" = "Blue" 
     "g" = "Green" 
     "c" ="Cyan" 
     "r" = "Red" 
     "m" = "Magenta" 
     "y" = "Yellow" 
     "w" = "White" 
    }

    $listen=$false
    $colorMode=$null
    $skipChar = 0

    for($i=0 ; $i -lt $String.Length; $i++)
    {
        $char = $String[$i]
        # If last ` was end ` then set list to false and color to false
        if ($colorMode -ne $null -and $listen -eq $true)
        {
            $colorMode = $null
            $listen = $false
        }
        # If listen is true and Char is a mapping char then set color mode to color name
        if ($listen -eq $true) 
        {
            $colorMapping = $null
            $nextChar = $String[$i+1]
            $twoChars = "$char$nextChar"
            # Color is dark color or black or gray
            if ($char -eq 'd' -or $twoChars -eq 'bk' -or $twoChars -eq 'gy')
            {
                $colorMapping = $twoChars
            }
            else
            {
                $colorMapping = $char.ToString()
            }
            if ($COLOR_MAPPING.Contains($colorMapping)) 
            {
                $colorName = $COLOR_MAPPING[$colorMapping]
                $listen = $false
                $colorMode = $colorName
                $char = ""
                if ($colorMapping.Length -eq 2){$skipChar = 2}
            }
            else{$listen = $false}

        }
        # If char is ` then listen for mapping char
        if ($char -eq '`')
        {
            $listen = $true
        }
        if ($skipChar -eq 1) {$char = ""; $skipChar = 0}
        if ($skipChar -eq 2 ) {$skipChar = 1}
        if ($colorMode -eq $null -and !$listen) 
        {
            Write-Host $char -NoNewLine
        }
        elseif(!$listen)
        {
            Write-Host -ForegroundColor $colorMode $char -NoNewline
        }
    }
}