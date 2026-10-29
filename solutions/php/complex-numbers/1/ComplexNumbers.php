<?php

/*
 * By adding type hints and enabling strict type checking, code can become
 * easier to read, self-documenting and reduce the number of potential bugs.
 * By default, type declarations are non-strict, which means they will attempt
 * to change the original type to match the type specified by the
 * type-declaration.
 *
 * In other words, if you pass a string to a function requiring a float,
 * it will attempt to convert the string value to a float.
 *
 * To enable strict mode, a single declare directive must be placed at the top
 * of the file.
 * This means that the strictness of typing is configured on a per-file basis.
 * This directive not only affects the type declarations of parameters, but also
 * a function's return type.
 *
 * For more info review the Concept on strict type checking in the PHP track
 * <link>.
 *
 * To disable strict typing, comment out the directive below.
 */

declare(strict_types=1);

class ComplexNumbers
{
    /**
     * @param float $real The real part (a)
     * @param float $imaginary The imaginary part (b)
     */
    public function __construct(
        public readonly float $real,
        public readonly float $imaginary = 0.0
    ) {
    }

    /**
     * Addition: z1 + z2 = (a + c) + (b + d) * i
     */
    public function add(ComplexNumbers $other): ComplexNumbers
    {
        return new ComplexNumbers(
            $this->real + $other->real,
            $this->imaginary + $other->imaginary
        );
    }

    /**
     * Subtraction: z1 - z2 = (a - c) + (b - d) * i
     */
    public function sub(ComplexNumbers $other): ComplexNumbers
    {
        return new ComplexNumbers(
            $this->real - $other->real,
            $this->imaginary - $other->imaginary
        );
    }

    /**
     * Multiplication: z1 * z2 = (a * c - b * d) + (b * c + a * d) * i
     */
    public function mul(ComplexNumbers $other): ComplexNumbers
    {
        return new ComplexNumbers(
            ($this->real * $other->real) - ($this->imaginary * $other->imaginary),
            ($this->imaginary * $other->real) + ($this->real * $other->imaginary)
        );
    }

    /**
     * Division: z1 / z2 = (a * c + b * d) / (c^2 + d^2) + (b * c - a * d) / (c^2 + d^2) * i
     */
    public function div(ComplexNumbers $other): ComplexNumbers
    {
        $denominator = ($other->real * $other->real) + ($other->imaginary * $other->imaginary);
        
        return new ComplexNumbers(
            (($this->real * $other->real) + ($this->imaginary * $other->imaginary)) / $denominator,
            (($this->imaginary * $other->real) - ($this->real * $other->imaginary)) / $denominator
        );
    }

    /**
     * Absolute Value: |z| = sqrt(a^2 + b^2)
     */
    public function abs(): float
    {
        return sqrt(($this->real * $this->real) + ($this->imaginary * $this->imaginary));
    }

    /**
     * Conjugate: zc = a - b * i
     */
    public function conjugate(): ComplexNumbers
    {
        return new ComplexNumbers($this->real, -$this->imaginary);
    }

    /**
     * Exponentiation: e^(a + b * i) = e^a * (cos(b) + i * sin(b))
     */
    public function exp(): ComplexNumbers
    {
        $expReal = exp($this->real);
        
        return new ComplexNumbers(
            $expReal * cos($this->imaginary),
            $expReal * sin($this->imaginary)
        );
    }
}