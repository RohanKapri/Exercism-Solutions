using namespace System.Collections.Generic
using namespace System.Text

enum Status { Finished; Loop }

Function Invoke-Camicia() {
    <#
    .SYNOPSIS
    Simulate a game very similar to the classic card game Camicia.

    .DESCRIPTION
    Given two hands of cards, simulate a game (similar to Camicia) until it ends (or detect if it is in a loop).
    Read instruction for rules and game example.

    .PARAMETER PlayerA
    An array of string(s) represents the first player's cards.

    .PARAMETER PlayerB
    An array of string(s) represents the second player's cards.
    #>
    [CmdletBinding()]
    Param(
        [string[]]$PlayerA,
        [string[]]$PlayerB
    )
    $status = [Status]::Loop
    $gameState = [GameState]::new($PlayerA, $PlayerB)
    $priorStates = [Collections.Generic.HashSet[string]]::new()
    while ($true) {
        $currentState = $gameState.GetState()
        if ($currentState -in $priorStates) { break }
        if ($currentState -match "[JQKA]") { [void]$priorStates.Add($currentState) }
        if ($gameState.PlayTurnAndCheckIfDone()) {
            $status = [Status]::Finished
            break
        }
    }

    [PSCustomObject]@{Status = $status; Cards = $gameState.CardsPlayed; Tricks = $gameState.Tricks}
}

class GameState {
    hidden [Collections.Generic.Queue[string][]]$Hands
    hidden [Collections.Generic.List[string]]$Pile = [Collections.Generic.List[string]]::new()
    hidden [int]$CurrentPlayer = 0
    hidden [int]$Debt = 0
    [int]$CardsPlayed = 0
    [int]$Tricks = 0

    GameState([string[]]$PlayerA, [string[]]$PlayerB) {
        $this.Hands = @(
            [Collections.Generic.Queue[string]]::new($PlayerA), [Collections.Generic.Queue[string]]::new($PlayerB)
        )
    }

    [bool] PlayTurnAndCheckIfDone() {
        while ($true) {
            $origDebt = $this.Debt
            $thisHand = $this.Hands[$this.CurrentPlayer]
            $otherHand = $this.Hands[1 - $this.CurrentPlayer]
            if ($thisHand.Count -eq 0) {
                $this.TransferPile()
                break
            }

            $topCard = $thisHand.Dequeue()
            $this.Pile.Add($topCard)
            $this.CardsPlayed++

            $newDebt = "JQKA".IndexOf($topCard) + 1
            if ($newDebt) { $this.Debt = $newDebt }
            else {
                $this.Debt = [Math]::Max($this.Debt - 1, 0)
                if ($origDebt -gt 0 -and $this.Debt -eq 0) {
                    $this.TransferPile()
                    $this.NextPlayer()
                    break
                }
            }

            if ($newDebt -ne 0 -or $this.Debt -eq 0) { $this.NextPlayer() }
        }

        return ($this.Pile.Count -eq 0 -and ($this.Hands[0].Count -eq 0 -or $this.Hands[1].Count -eq 0))
    }

    [string] GetState() {
        return ($this.Hands | ForEach-Object { -join ($_ -replace "[^JQKA]+", "-") }) -join " "
    }

    hidden [void] TransferPile() {
        $this.Pile | ForEach-Object { $this.Hands[1 - $this.CurrentPlayer].Enqueue($_) }
        $this.Pile.Clear()
        $this.Tricks++
    }

    hidden [void] NextPlayer() { $this.CurrentPlayer = 1 - $this.CurrentPlayer }
}