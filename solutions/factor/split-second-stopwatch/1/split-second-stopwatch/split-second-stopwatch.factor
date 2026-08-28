USING: accessors arrays formatting kernel locals math math.parser sequences splitting vectors ;
IN: split-second-stopwatch

:: display-time ( time -- str )
    time 3600 /mod 60 /mod
    "%02d:%02d:%02d" sprintf ;

: parse-time ( str -- seconds )
    ":" split 0 [ string>number swap 60 * + ] reduce ;


TUPLE: stopwatch state current past ;

: <stopwatch> ( -- stopwatch )
    "ready" 0 V{ } clone stopwatch boa ;

: state ( stopwatch -- str )
    state>> ;

: current-lap ( stopwatch -- str )
    current>> display-time ;

: total ( stopwatch -- str )
    [ current>> ] [ past>> sum ] bi + display-time ;

: previous-laps ( stopwatch -- seq )
    past>> [ display-time ] map >array ;

:: advance-time ( str stopwatch -- )
    stopwatch state>> "running" =
    [
        stopwatch [ str parse-time + ] change-current drop
    ]
    when ;

: start ( stopwatch -- )
    dup state>> "running" = [ "cannot start an already running stopwatch" throw ] when
    "running" >>state drop ;

: stop ( stopwatch -- )
    dup state>> "running" = [ "cannot stop a stopwatch that is not running" throw ] unless
    "stopped" >>state drop ;

:: reset ( stopwatch -- )
    stopwatch state>> "stopped" = [ "cannot reset a stopwatch that is not stopped" throw ] unless
    stopwatch
    "ready" >>state
    0 >>current
    past>> delete-all ;

:: lap ( stopwatch -- )
    stopwatch state>> "running" = [ "cannot lap a stopwatch that is not running" throw ] unless
    stopwatch current>> stopwatch past>> push
    stopwatch 0 >>current drop ;