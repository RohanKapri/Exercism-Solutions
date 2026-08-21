<#
.SYNOPSIS
    Implement the logic for a word-guessing game.
.DESCRIPTION
    Implement the logic and functionalities of a word-guessing game.
    The game has 3 states: WIN, LOSE and ONGOING.
    You are allowed to fail 9 times.
    Incorrect guess and repeating guess will decrease the remaining failures by 1.
    You win when you correctly guess the word.
#>

Enum Status {
    WIN
    LOSE
    ONGOING
}

Class WordGame {
    [int] $RemainingFailures = 9
    [Status] $State = [Status]::ONGOING
    hidden [char[]]$Word
    hidden [char[]]$Displayed

    WordGame([string] $word) {
        $this.Word = $word
        $this.Displayed = @("_") * $word.Length
    }

    [void] Guess([char]$letter) {
        if ($this.State -ne [Status]::ONGOING) {
            Throw "Can't make further guess. Game is already finished : You $($this.State)"
        }

        if ($letter -in $this.Word -and $letter -notin $this.Displayed) {
            0..$this.word.Length | Where-Object { $this.Word[$_] -eq $letter } |
                ForEach-Object { $this.Displayed[$_] = $letter }
            if ("_" -notin $this.Displayed) { $this.State = [Status]::WIN }
        } else {
            if ($this.RemainingFailures -gt 0) { $this.RemainingFailures-- }
            else { $this.State = [Status]::LOSE }
        }
    }

    [string] Display() { return -join $this.Displayed }
}