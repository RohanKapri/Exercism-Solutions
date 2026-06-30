<?php

declare(strict_types=1);

function saddlePoints(array $matrix): array
{
    if ($matrix === [] || $matrix[0] === []) {
        return [];
    }

    $rowMax = [];
    foreach ($matrix as $row) {
        $rowMax[] = max($row);
    }

    $cols = count($matrix[0]);
    $colMin = [];

    for ($c = 0; $c < $cols; $c++) {
        $min = $matrix[0][$c];
        foreach ($matrix as $row) {
            $min = min($min, $row[$c]);
        }
        $colMin[$c] = $min;
    }

    $result = [];

    foreach ($matrix as $r => $row) {
        foreach ($row as $c => $value) {
            if ($value === $rowMax[$r] && $value === $colMin[$c]) {
                $result[] = [
                    'row' => $r + 1,
                    'column' => $c + 1,
                ];
            }
        }
    }

    return $result;
}