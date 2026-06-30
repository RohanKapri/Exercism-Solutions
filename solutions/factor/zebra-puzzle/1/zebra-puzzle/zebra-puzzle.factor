USING: combinators kernel math math.combinatorics sequences ;
IN: zebra-puzzle

SYMBOLS: Englishman Spaniard Ukrainian Norwegian Japanese ;

SYMBOLS: DrinksWater OwnsZebra ;

:: answer ( question -- nationality )

    f :> result!

    { 1 2 3 4 5 }
    [| nationalities |
        0 nationalities nth :> englishman
        1 nationalities nth :> japanese
        2 nationalities nth :> norwegian
        3 nationalities nth :> spaniard
        4 nationalities nth :> ukrainian

        ! 10. The Norwegian lives in the first house.
        norwegian 1 =
        [
            { 1 2 3 4 5 }
            [| colors |
                0 colors nth :> blue
                1 colors nth :> green
                2 colors nth :> ivory
                3 colors nth :> red
                4 colors nth :> yellow

                ! 2. The Englishman lives in the red house.
                ! 6. The green house is immediately to the right of the ivory house.
                ! 15. The Norwegian lives next to the blue house.
                englishman red =
                green ivory 1 + =
                norwegian blue - abs 1 =
                and and
                [
                    { 1 2 3 4 5 }
                    [| drinks |
                        0 drinks nth :> coffee
                        1 drinks nth :> milk
                        2 drinks nth :> orange-juice
                        3 drinks nth :> tea
                        4 drinks nth :> water

                        ! 4. Coffee is drunk in the green house.
                        ! 5. The Ukrainian drinks tea.
                        ! 9. Milk is drunk in the middle house.
                        coffee green =
                        ukrainian tea =
                        milk 3 =
                        and and
                        [
                            { 1 2 3 4 5 }
                            [| hobbies |
                                0 hobbies nth :> reading
                                1 hobbies nth :> painting
                                2 hobbies nth :> football
                                3 hobbies nth :> dancing
                                4 hobbies nth :> chess

                                ! 8. The person in the yellow house is a painter.
                                ! 13. The person who plays football drinks orange juice.
                                ! 14. The Japanese person plays chess.
                                yellow painting =
                                football orange-juice =
                                japanese chess =
                                and and
                                [
                                    { 1 2 3 4 5 }
                                    [| pets |
                                        0 pets nth :> dog
                                        1 pets nth :> fox
                                        2 pets nth :> horse
                                        3 pets nth :> snails
                                        4 pets nth :> zebra

                                        ! 3. The Spaniard owns the dog.
                                        ! 7. The snail owner likes to go dancing.
                                        ! 11. The person who enjoys reading lives in the house next to the person with the fox.
                                        ! 12. The painter's house is next to the house with the horse.
                                        spaniard dog =
                                        snails dancing =
                                        reading fox - abs 1 =
                                        painting horse - abs 1 =
                                        and and and
                                        [
                                            question
                                            {
                                                { DrinksWater [ water ] }
                                                { OwnsZebra [ zebra ] }
                                                [ drop f ]
                                            }
                                            case

                                            {
                                                { englishman [ Englishman ] }
                                                { japanese [ Japanese ] }
                                                { norwegian [ Norwegian ] }
                                                { spaniard [ Spaniard ] }
                                                { ukrainian [ Ukrainian ] }
                                                [ drop f ]
                                            }
                                            case
                                            result!
                                        ]
                                        when
                                    ]
                                    each-permutation
                                ]
                                when
                            ]
                            each-permutation
                        ]
                        when
                    ]
                    each-permutation
                ]
                when
            ]
            each-permutation
        ]
        when
    ]
    each-permutation

    result ;

: drinks-water ( -- nationality )
    DrinksWater answer ;

: owns-zebra ( -- nationality )
    OwnsZebra answer ;