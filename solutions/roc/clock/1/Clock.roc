module [create, to_str, toStr, add, subtract]

Clock : { hour : U8, minute : U8 }

minutes_per_hour : I64
minutes_per_hour = 60

minutes_per_day : I64
minutes_per_day = 24 * minutes_per_hour

create : { hours ?? I64, minutes ?? I64 }* -> Clock
create = |args|
    args
    |> normalize_minutes
    |> to_clock

to_str : Clock -> Str
to_str = |{ hour, minute }|
    Str.concat(
        pad(Num.to_i64(hour)),
        Str.concat(":", pad(Num.to_i64(minute)))
    )

toStr : Clock -> Str
toStr = to_str

add : Clock, { hours ?? I64, minutes ?? I64 }* -> Clock
add = |clock, args|
    adjust(clock, normalize_minutes(args))

subtract : Clock, { hours ?? I64, minutes ?? I64 }* -> Clock
subtract = |clock, args|
    adjust(clock, Num.neg(normalize_minutes(args)))

adjust : Clock, I64 -> Clock
adjust = |clock, delta|
    clock
    |> clock_minutes
    |> Num.add(delta)
    |> modulo(minutes_per_day)
    |> to_clock

clock_minutes : Clock -> I64
clock_minutes = |{ hour, minute }|
    (Num.to_i64(hour) * minutes_per_hour) + Num.to_i64(minute)

normalize_minutes : { hours ?? I64, minutes ?? I64 }* -> I64
normalize_minutes = |{ hours ?? 0, minutes ?? 0 }|
    hour_part =
        Num.rem(hours, 24) * minutes_per_hour
    minute_part =
        Num.rem(minutes, minutes_per_day)

    modulo(hour_part + minute_part, minutes_per_day)

to_clock : I64 -> Clock
to_clock = |total|
    {
        hour: Num.to_u8(Num.div_trunc(total, minutes_per_hour)),
        minute: Num.to_u8(Num.rem(total, minutes_per_hour)),
    }

modulo : I64, I64 -> I64
modulo = |value, modulus|
    remainder = Num.rem(value, modulus)
    if remainder < 0 then
        remainder + modulus
    else
        remainder

pad : I64 -> Str
pad = |value|
    value_str = Num.to_str(value)
    if value < 10 then
        Str.concat("0", value_str)
    else
        value_str
                