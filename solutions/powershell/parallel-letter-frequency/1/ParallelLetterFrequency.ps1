Function Get-LetterFrequencies() {
    <#
    .SYNOPSIS
    Count the frequency of letters in texts using parallel computation.

    .PARAMETER Texts
    An array of strings.
    #>
    [CmdletBinding()]
    Param(
        [string[]]$Texts
    )

    $counts = @{}
    $Texts | ForEach-Object -Parallel { 
        $intermediate = @{}
        foreach($c in ($_ -replace '[\d\W]', "").ToLower().ToCharArray()) { $intermediate[$c]++ }
        $intermediate
    } -ThrottleLimit 32 | ForEach-Object { $_.GetEnumerator() | ForEach-Object { $counts["$($_.Key)"] += $_.Value }}

    $counts
}