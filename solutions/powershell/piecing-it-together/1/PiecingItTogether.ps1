<#
.SYNOPSIS
Given partial information about a jigsaw puzzle, add the missing pieces.

.DESCRIPTION
Calculate properties of a jigsaw puzzle with given information if possible.
If not possible due to insufficient or incorrect information, the user should be notified.
Read instructions for more information and example.
#>

enum Format { Unknown; Portrait; Square; Landscape }

class JigsawPuzzle {
    [Nullable[int]]$Pieces
    [Nullable[int]]$Border
    [Nullable[int]]$Inside
    [Nullable[int]]$Rows
    [Nullable[int]]$Columns
    [Nullable[double]]$AspectRatio
    [Nullable[Format]]$Format

    [string[]] static hidden $fields = @("Pieces", "Border", "Inside", "Rows", "Columns", "AspectRatio", "Format")

    GetData([PSCustomObject]$partialData)
    {
        foreach ($field in [JigsawPuzzle]::fields) {
            if ($partialData.$field) { $this.$field = $partialData.$field }
        }

        $this.GetFormatFromAspectRatio()
        $this.GetDataForSquare()
        $this.GetRowsAndColumnsFromPiecesAndAspectRatio()
        $this.GetColumnsFromRowsAndAspectRatio()
        $this.GetBorderAndInsideFromRowsAndColumns()
        $this.GetDataFromPiecesBorderAndFormat()

        foreach ($field in [JigsawPuzzle]::fields) {
            if ($this.$field -eq $null) { throw "insufficient data" }
        }
    }


    [void] SetValue([string]$field, $value) {
        if ($this.$field -eq $value) { return }
        if ($this.$field -ne $null) { throw "contradictory data" }
        $this.$field = $value
    }

    [void] GetFormatFromAspectRatio() {
        if ($this.AspectRatio -eq $null) { return }
        if ($this.AspectRatio -eq 1.0) { $this.SetValue("Format", "Square") }
        else { $this.SetValue("Format", (($this.AspectRatio -lt 1.0) ? "Portrait" : "Landscape")) }
    }

    [void] GetDataForSquare() {
        if ($this.Format -ne "Square" -and $this.AspectRatio -ne 1.0) { return }

        $this.SetValue("AspectRatio", 1.0)
        $this.SetValue("Format", "Square")
        if ($this.Inside -ne $null) {
            $s = [int][Math]::Round([Math]::Sqrt($this.Inside)) + 2
            $this.SetValue("Rows", $s)
        }

        if ($this.Rows -ne $null -or $this.Columns -ne $null) {
            $s = $this.Rows ?? $this.Columns
            $this.SetValue("Rows", $s)
            $this.SetValue("Columns", $s)
            $this.SetValue("Pieces", ($s * $s))
        }
    }

    [void] GetColumnsFromRowsAndAspectRatio() {
        if ($this.Rows -eq $null -or $this.AspectRatio -eq $null) { return }
        $this.SetValue("Columns", ($this.Rows * $this.AspectRatio))
    }

    [void] GetRowsAndColumnsFromPiecesAndAspectRatio() {
        if ($this.Pieces -eq $null -or $this.AspectRatio -eq $null) { return }
        $r = [int][Math]::Round([Math]::Sqrt($this.Pieces / $this.AspectRatio))
        $c = [int][Math]::Round($r * $this.AspectRatio)
        $this.SetValue("Rows", $r)
        $this.SetValue("Columns", $c)
    }

    [void] GetBorderAndInsideFromRowsAndColumns() {
        if ($this.Rows -eq $null -or $this.Columns -eq $null) { return }
        $border_ = 2 * ($this.Rows + $this.Columns) - 4
        $pieces_ = $this.Rows * $this.Columns
        $this.SetValue("Border", $border_)
        $this.SetValue("Inside", ($pieces_ - $border_))
        $this.SetValue("Pieces", $pieces_)
    }

    [void] GetDataFromPiecesBorderAndFormat() {
        if ($this.Pieces -eq $null -or $this.Border -eq $null -or $this.Format -eq $null) { return }
        $border_ = $this.Border
        $this.SetValue("Inside", ($this.Pieces - $border_))

        $d = [int][Math]::sqrt(16 + 8 * $border_ + $border_ * $border_ - 16 * $this.Pieces)
        $x = [int](($border_ + 4 + $d) / 4)
        $y = [int]($this.Pieces / $x)
        $trialBorder = 2 * ($x + $y) - 4
        if ($border_ -eq $trialBorder) {
            $r = ($this.Format -eq "Portrait") ? $x : $y
            $c = ($this.Format -eq "Portrait") ? $y : $x
            $this.SetValue("Rows", $r)
            $this.SetValue("Columns", $c)
            $this.SetValue("AspectRatio", ($c / $r))
        }
    }
}