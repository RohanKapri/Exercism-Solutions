<?php declare(strict_types=1);

function format(string $name, int $number): string
{
    $suffix = match ($number % 100) {
        11, 12, 13 => 'th',
        default => match ($number % 10) {
            1 => 'st',
            2 => 'nd',
            3 => 'rd',
            default => 'th',
        }
    };
    return "{$name}, you are the {$number}{$suffix} customer we serve today. Thank you!";
}