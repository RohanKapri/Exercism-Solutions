<#
.SYNOPSIS
    Finds the sequence of prisms hit by a laser.

.DESCRIPTION
    Determines the order in which a laser beam encounters prisms based on
    the laser's starting position and angle. After hitting a prism, the
    laser is moved to that prism and its angle is adjusted by the prism's
    refraction angle.
#>

class Laser {
    [double]$X
    [double]$Y
    [double]$Angle

    Laser() {
        $this.X = 0.0
        $this.Y = 0.0
        $this.Angle = 0.0
    }

    Laser([double]$angle) {
        $this.X = 0.0
        $this.Y = 0.0
        $this.Angle = $angle
    }

    Laser([double]$x, [double]$y, [double]$angle) {
        $this.X = $x
        $this.Y = $y
        $this.Angle = $angle
    }
}

class Prism {
    [int]$Id
    [double]$X
    [double]$Y
    [double]$Angle

    Prism() {
        $this.Id = 0
        $this.X = 0.0
        $this.Y = 0.0
        $this.Angle = 0.0
    }

    Prism([int]$id, [double]$x, [double]$y, [double]$angle) {
        $this.Id = $id
        $this.X = $x
        $this.Y = $y
        $this.Angle = $angle
    }
}

Function Get-PrismSequence() {
    [CmdletBinding()]
    Param(
        [Laser]$Laser,
        [Prism[]]$Prisms
    )

    if ($null -eq $Laser) {
        $Laser = [Laser]::new()
    }

    if ($null -eq $Prisms -or $Prisms.Count -eq 0) {
        return @()
    }

    $currentX = $Laser.X
    $currentY = $Laser.Y
    $currentAngle = $Laser.Angle

    $sequence = [System.Collections.Generic.List[int]]::new()
    $maxIterations = 10000
    $iteration = 0

    while ($iteration -lt $maxIterations) {
        $iteration++

        $rad = $currentAngle * [Math]::PI / 180.0
        $cosA = [Math]::Cos($rad)
        $sinA = [Math]::Sin($rad)

        [Prism]$bestPrism = $null
        [double]$minDistance = [double]::PositiveInfinity

        foreach ($prism in $Prisms) {
            $vx = $prism.X - $currentX
            $vy = $prism.Y - $currentY

            # Distance along the ray
            $t = $vx * $cosA + $vy * $sinA

            # Must be forward along the beam path
            if ($t -gt 1e-4) {
                # Perpendicular distance to the beam line
                $dPerp = [Math]::Abs($vx * $sinA - $vy * $cosA)
                if ($dPerp -lt 0.01) {
                    if ($t -lt $minDistance) {
                        $minDistance = $t
                        $bestPrism = $prism
                    }
                }
            }
        }

        # Beam continues into empty space
        if ($null -eq $bestPrism) {
            break
        }

        $sequence.Add($bestPrism.Id)
        $currentX = $bestPrism.X
        $currentY = $bestPrism.Y
        $currentAngle += $bestPrism.Angle
    }

    if ($sequence.Count -eq 0) {
        return @()
    }

    return , [int[]]$sequence.ToArray()
}