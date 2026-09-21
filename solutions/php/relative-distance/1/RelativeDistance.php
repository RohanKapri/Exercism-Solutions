<?php

declare(strict_types=1);

function degreeOfSeparation(array $familyTree, string $personA, string $personB): int
{
    // Convert family tree into an undirected graph
    $relatives = [];
    foreach ($familyTree as $parent => $children) {
        foreach ($children as $i => $childA) {
            // Connect parent and children
            $relatives[$parent][$childA] = true;
            $relatives[$childA][$parent] = true;

            // Connect siblings
            for ($j = $i + 1; $j < count($children); $j++) {
                $relatives[$childA][$children[$j]] = true;
                $relatives[$children[$j]][$childA] = true;
            }
        }
    }

    // If either person is not in the graph, indicate not related
    if (!isset($relatives[$personA], $relatives[$personB])) {
        return -1;
    }

    // Do breadth first search from person A to person B
    $queue = [[$personA, 0]];
    $visited = [];
    while (!empty($queue)) {
        [$person, $distance] = array_shift($queue);
        if ($person == $personB) {
            return $distance;
        }

        foreach (array_keys($relatives[$person]) as $relative) {
            if (!isset($visited[$relative])) {
                $queue[] = [$relative, $distance + 1];
                $visited[$relative] = true;
            }
        }
    }

    return -1;
}