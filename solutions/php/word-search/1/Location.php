<?php
declare(strict_types=1);
final readonly class Location
{
    public function __construct(private readonly int $column, private readonly int $row)
    {
    }
}