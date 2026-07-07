USING: calendar combinators formatting kernel math math.parser sequences splitting ;
IN: gigasecond

: parse-date ( str -- year month day )
    "-" split [ string>number ] map first3 ;

: parse-time ( str -- hour minute second )
    ":" split [ string>number ] map first3 ;

: gigasecond-after ( moment -- moment )
    "T" split1 [ parse-date ] [ "00:00:00" or parse-time ] bi*
    instant <timestamp>
    1000000000 seconds time+
    [ >date< ] [ >time< ] bi
    "%04d-%02d-%02dT%02d:%02d:%02d" sprintf ;