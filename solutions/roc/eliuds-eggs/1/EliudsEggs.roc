module [egg_count]

egg_count : U64 -> U64
egg_count = |number|
    count_bits(number, 0)

count_bits : U64, U64 -> U64
count_bits = |number, count|
    if number == 0 then
        count
    else
        # Check if least significant bit is 1
        bit = Num.bitwise_and(number, 1)
        # Right shift to process next bit
        count_bits(Num.shift_right_by(number, 1), count + bit)
     