! Dedicated to Junko F. Didi and Shree DR.MDD

USING: combinators kernel math sequences unicode ;
IN: phone-number

ERROR: invalid-phone-number ;

: clean-ten ( phrase -- digits )
    dup
    [
        first
        CHAR: 2 <
    ]
    [
        fourth
        CHAR: 2 <
    ]
    bi
    or
    [
        drop
        invalid-phone-number
    ]
    when ;

: clean ( phrase -- digits )
    [ CHAR: 0 >= ] filter

    dup
    [ digit? not ] any?
    [
        invalid-phone-number
    ]
    when

    dup length
    {
        {
            10
            [
                clean-ten
            ]
        }
        {
            11
            [
                dup
                first
                CHAR: 1 =
                not
                [
                    invalid-phone-number
                ]
                when

                1 tail
                clean-ten
            ]
        }
        [
            drop
            invalid-phone-number
        ]
    }
    case ;