USING: calendar calendar.english combinators kernel locals math sequences ;
IN: meetup

:: meetup ( year month week dayofweek -- timestamp )
    week
    {
        { "teenth" [ 19 ] }
        { "first" [ 7 ] }
        { "second" [ 14 ] }
        { "third" [ 21 ] }
        { "fourth" [ 28 ] }
        { "last" [ year month 1 <date>  days-in-month ] }
        [ drop -1 ]
    }
    case :> end-of-week

    end-of-week

    year month end-of-week <date> day-of-week
    dayofweek day-names index
    - 7 + 7 mod

    - :> day

    year month day <date> ;