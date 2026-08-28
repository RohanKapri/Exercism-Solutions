USING: calendar calendar.english kernel locals sequences ;
IN: ferry-schedule

: make-date ( year month day -- timestamp )
    <date> ;

: weekday-name ( timestamp -- name )
    day-of-week day-names nth ;

: leap? ( year -- ? )
    1 1 <date> leap-year? ;

: month-length ( year month -- n )
    1 <date> days-in-month ;

: add-days ( timestamp n -- timestamp )
    days time+ ;