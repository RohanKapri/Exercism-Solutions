USING: combinators kernel locals math math.order ranges sequences ;
IN: rectangles

CONSTANT: plus 43
CONSTANT: minus 45
CONSTANT: bar 124

:: horizontal ( left right str -- ? )
    left str nth plus =
    right str nth plus =
    and
    [
        left right (a..b)
        [| column |
            column str nth [ plus = ] [ minus = ] bi or
        ]
        all?
    ]
    [
        f
    ]
    if ;

:: count-rectangles ( grid -- n )
    0 :> result!
    f :> top!
    f :> left!
    f :> right!
    f :> bottom!

    grid length bottom!
    [ bottom 1 > ]
    [
        bottom 1 - bottom!

        bottom grid nth length right!
        [ right 1 > ]
        [
            right 1 - right!

            right  bottom grid nth  nth plus =
            [
                right left!

                [
                    left 0 >
                    [
                        left 1 - left!
                        left  bottom grid nth  nth [ plus = ] [ minus = ] bi or
                    ]
                    [
                        f
                    ]
                    if
                ]
                [
                    left  bottom grid nth  nth plus =
                    [
                        bottom top!

                        [
                            top 0 >
                            [
                                top 1 - top!
                                left  top grid nth  nth [ plus = ] [ bar = ] bi or
                                right  top grid nth  nth [ plus = ] [ bar = ] bi or
                                and
                            ]
                            [
                                f
                            ]
                            if
                        ]
                        [
                            left right
                            top grid nth
                            horizontal
                            [
                                result 1 + result!
                            ]
                            when
                        ]
                        while ! top
                    ]
                    when
                ]
                while ! left
            ]
            when
        ]
        while ! right
    ]
    while ! bottom

    result ;