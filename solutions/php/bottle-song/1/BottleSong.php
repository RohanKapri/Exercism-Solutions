<?php declare(strict_types=1);

final class BottleSong
{
    private const NUMERALS = [
        0 => "no",
        1 => "one",
        2 => "two",
        3 => "three",
        4 => "four",
        5 => "five",
        6 => "six",
        7 => "seven",
        8 => "eight",
        9 => "nine",
        10 => "ten",
    ];
    
    public function verse(int $number): string
    {
        $numeral = mb_ucfirst(self::NUMERALS[$number]);
        $next_numeral = self::NUMERALS[$number - 1];
        $bottle_plural = $number === 1 ? 'bottle' : 'bottles';
        $next_bottle_plural = $number === 2 ? 'bottle' : 'bottles';
        return <<<TEXT
            {$numeral} green {$bottle_plural} hanging on the wall,
            {$numeral} green {$bottle_plural} hanging on the wall,
            And if one green bottle should accidentally fall,
            There'll be {$next_numeral} green {$next_bottle_plural} hanging on the wall.
            TEXT;        
    }

    public function verses(int $start, int $size): string
    {
        $verses = [];
        for ($i = $start; $i > $start - $size; $i--) {
            $verses[] = $this->verse($i);
        }
        return implode("\n\n", $verses);
    }

    public function lyrics(): string
    {
        return $this->verses(10, 10);
    }
}