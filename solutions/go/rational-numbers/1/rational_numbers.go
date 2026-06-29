package rationalnumbers

import "math"

type Rational struct {
	numerator, denominator int
}

func abs(n int) int {
	if n < 0 {
		return -n
	}
	return n
}

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func pow(base, exp int) int {
	return int(math.Pow(float64(base), float64(exp)))
}

func (r Rational) Reduce() Rational {
	gcd := gcd(abs(r.numerator), abs(r.denominator))
	numerator := r.numerator / gcd
	denominator := r.denominator / gcd

	if denominator < 0 {
		numerator = -numerator
		denominator = -denominator
	}

	return Rational{numerator, denominator}
}

func (r Rational) Add(s Rational) Rational {
	numerator := r.numerator*s.denominator + s.numerator*r.denominator
	denominator := r.denominator * s.denominator

	return Rational{numerator, denominator}.Reduce()
}

func (r Rational) Sub(s Rational) Rational {
	return r.Add(Rational{-s.numerator, s.denominator})
}

func (r Rational) Mul(s Rational) Rational {
	return Rational{r.numerator * s.numerator, r.denominator * s.denominator}.Reduce()
}

func (r Rational) Div(s Rational) Rational {
	return r.Mul(Rational{s.denominator, s.numerator})
}

func (r Rational) Abs() Rational {
	return Rational{abs(r.numerator), abs(r.denominator)}.Reduce()
}

// Compute r ^ power, a rational raised to an int exponent.
func (r Rational) Exprational(power int) Rational {
	if power >= 0 {
		return Rational{pow(r.numerator, power), pow(r.denominator, power)}.Reduce()
	} else {
		return Rational{pow(r.denominator, -power), pow(r.numerator, -power)}.Reduce()
	}
}

// Compute base ^ r, an int raised to a rational.
func (r Rational) Expreal(base int) float64 {
	return math.Pow(float64(base), float64(r.numerator)/float64(r.denominator))
}