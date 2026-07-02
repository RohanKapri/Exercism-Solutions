<?php

declare(strict_types=1);

class GameOfLife
{
    public function __construct(public array $matrix)
    {
    }

    public function tick(): void
    {
        $rows = count($this->matrix);

        if ($rows === 0) {
            return;
        }

        $cols = count($this->matrix[0]);
        $next = [];

        for ($r = 0; $r < $rows; $r++) {
            $next[$r] = [];

            for ($c = 0; $c < $cols; $c++) {
                $liveNeighbors = 0;

                for ($dr = -1; $dr <= 1; $dr++) {
                    for ($dc = -1; $dc <= 1; $dc++) {
                        if ($dr === 0 && $dc === 0) {
                            continue;
                        }

                        $nr = $r + $dr;
                        $nc = $c + $dc;

                        if (
                            $nr >= 0 && $nr < $rows &&
                            $nc >= 0 && $nc < $cols &&
                            $this->matrix[$nr][$nc] === 1
                        ) {
                            $liveNeighbors++;
                        }
                    }
                }

                if ($this->matrix[$r][$c] === 1) {
                    $next[$r][$c] = ($liveNeighbors === 2 || $liveNeighbors === 3) ? 1 : 0;
                } else {
                    $next[$r][$c] = ($liveNeighbors === 3) ? 1 : 0;
                }
            }
        }

        $this->matrix = $next;
    }
}