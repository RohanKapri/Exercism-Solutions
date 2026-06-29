function Invoke-Alphametics {
    <#
    .SYNOPSIS
    Implement a solver for alphametic puzzles.

    .PARAMETER Puzzle
    The string represent the puzzle.
    #>
    [CmdletBinding()]
    Param(
        [string] $Puzzle
    )
    # Get words
    $words = ($Puzzle -split '\+|==').Trim()
    $numWords = $words.Length

    # Separate out first letters from other letters
    $letters = $words.ToCharArray() | Sort-Object -unique
    $firstLetters = $words | ForEach-Object { $_[0] } | Sort-Object -unique
    $otherLetters = $letters | Where-Object { $_ -notin $firstLetters }
    $letters = $firstLetters + $otherLetters
    $nFirst, $nOther = $firstLetters.Length, $otherLetters.Length
    Write-Host $Puzzle

    # Improve runtime by precomputing the multiplier for each letter.
    #
    # Each multiplier is the sum of 10**position of the letter counted from
    # right to left for each word. The left side words added, and the right
    # side word is subtracted. Therefore, the solution will be the combination
    # of letter values multiplied by its corresponding multiplier that adds up
    # to zero
    $multipliers = [hashtable]::new()
    $letters | ForEach-Object { $multipliers["$_"] = [int]0 }
    $n = 0
    $words | ForEach-Object {
        $multiplier = ($n++ -lt ($numWords - 1)) ? 1 : -1
        $k = 0
        $_.ToCharArray()[($_.Length - 1)..0] |
            ForEach-Object { $multipliers["$_"] += [int]($multiplier * [Math]::pow(10, $k++)) }
    }
    $firstMultipliers = @($firstLetters | ForEach-Object { $multipliers["$_"] })
    $otherMultipliers = @($otherLetters | ForEach-Object { $multipliers["$_"] })

    # First letters can be 1-9; all other letters can be 0-9. Try all possible
    # values for first letters and other letters. Stop when solution is found
    $candidatePool = 0..9
    foreach ($firstValues in Get-Permutations @(1..9) $nFirst) {
        $firstAns = Get-Answer $firstValues $firstMultipliers
        if ($nOther -lt 1 -and $firstAns -eq 0 ) { return Get-Solution $firstLetters $firstValues }
        $candidates = @($candidatePool | Where-Object { $_ -notin $firstValues })
        foreach ($otherValues in Get-Permutations $candidates $nOther) {
            $ans = $firstAns + (Get-Answer $otherValues $otherMultipliers)
            if ($ans -eq 0) { return Get-Solution $letters ($firstValues + $otherValues) }
        }
    }

    $null
}

# Based on https://docs.python.org/3/library/itertools.html#itertools.permutations
function Get-Permutations($pool, $r) {
    $n = $pool.Length
    if ($n -lt 1 -or $r -lt 1) { return @() }

    $indices = @(0..($n - 1))
    $cycles = @($n..($n - $r + 1))
    Write-Output @(, $pool[0..($r - 1)])

    do {
        $done = $true
        for ($i = $r - 1; $i -ge 0; $i--) {
            $cycles[$i]--
            if ($cycles[$i] -eq 0) {
                $indices = $indices[
                    (($i -gt 0) ? @(0..($i - 1)) : @()) + (($i -lt $n - 1) ? @(($i + 1)..($n - 1)) : @()) + @($i)
                ]
                $cycles[$i] = $n - $i
            } else {
                $k = $n - $cycles[$i]
                $indices[$i], $indices[$k] = $indices[$k], $indices[$i]
                Write-Output @(, $pool[$indices[0..($r - 1)]])
                $done = $false
                break
            }
        }
    } while (!$done)
}

function Get-Answer($values, $multipliers) {
    $ans = 0
    $n = 0
    foreach ($value in $values) { $ans += $value * $multipliers[$n++] }
    $ans
}

function Get-Solution($letters, $values) {
    $solution = [hashtable]::new()
    $n = 0
    $letters | ForEach-Object { $solution["$_"] = $values[$n++] }
    $solution
}