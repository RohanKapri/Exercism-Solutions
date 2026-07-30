<?php
declare(strict_types=1);
final readonly class Result
{
    public function __construct(private readonly Location $start, private readonly Location $end)
    {
    }
}
