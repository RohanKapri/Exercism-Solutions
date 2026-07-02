module [add, sub, mul, div, abs, exp, exp_real, reduce]

## Greatest common divisor (Euclidean algorithm)
gcd : I64, I64 -> I64
gcd = |a, b|
    if b == 0 then a else gcd(b, a % b)

pow_i64 : I64, U64 -> I64
pow_i64 = |base, n|
    pow_help(base, n, 1i64)

pow_help : I64, U64, I64 -> I64
pow_help = |base, n, acc|
    if n == 0 then
        acc
    else if n % 2 == 1 then
        pow_help(base * base, n // 2, acc * base)
    else
        pow_help(base * base, n // 2, acc)

## Reduce to lowest terms; denominator always positive
reduce : [Rational I64 I64] -> [Rational I64 I64]
reduce = |Rational(a, b)|
    if a == 0 then
        Rational(0, 1)
    else
        g = gcd(Num.abs(a), Num.abs(b))
        na = a // g
        nb = b // g
        if nb < 0 then Rational(-na, -nb) else Rational(na, nb)

add : [Rational I64 I64], [Rational I64 I64] -> [Rational I64 I64]
add = |Rational(a1, b1), Rational(a2, b2)|
    reduce(Rational(a1 * b2 + a2 * b1, b1 * b2))

sub : [Rational I64 I64], [Rational I64 I64] -> [Rational I64 I64]
sub = |Rational(a1, b1), Rational(a2, b2)|
    reduce(Rational(a1 * b2 - a2 * b1, b1 * b2))

mul : [Rational I64 I64], [Rational I64 I64] -> [Rational I64 I64]
mul = |Rational(a1, b1), Rational(a2, b2)|
    reduce(Rational(a1 * a2, b1 * b2))

div : [Rational I64 I64], [Rational I64 I64] -> [Rational I64 I64]
div = |Rational(a1, b1), Rational(a2, b2)|
    reduce(Rational(a1 * b2, b1 * a2))

abs : [Rational I64 I64] -> [Rational I64 I64]
abs = |Rational(a, b)|
    reduce(Rational(Num.abs(a), Num.abs(b)))

exp : [Rational I64 I64], I64 -> [Rational I64 I64]
exp = |Rational(a, b), n|
    if n == 0 then
        Rational(1, 1)
    else if n > 0 then
        m = Num.to_u64(n)
        reduce(Rational(pow_i64(a, m), pow_i64(b, m)))
    else
        m = Num.to_u64(-n)
        reduce(Rational(pow_i64(b, m), pow_i64(a, m)))

exp_real : F64, [Rational I64 I64] -> F64
exp_real = |x, Rational(a, b)|
    Num.pow(x, Num.to_f64(a) / Num.to_f64(b))