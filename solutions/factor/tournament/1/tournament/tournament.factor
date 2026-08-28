USING: accessors arrays assocs combinators formatting kernel locals math sequences sorting splitting ;
IN: tournament

TUPLE: team name won drawn lost ;

: <team> ( name -- team )
    0 0 0 team boa ;

:: played ( team -- n )
    team [ won>> ] [ drawn>> ] [ lost>> ] tri + + ;

:: points ( team -- n )
    team [ won>> 3 * ] [ drawn>> ] bi + ;

CONSTANT: header "Team                           | MP |  W |  D |  L |  P"

:: summary ( team -- str )
  team name>>
  team played
  team won>>
  team drawn>>
  team lost>>
  team points
  "%-31s|%3d |%3d |%3d |%3d |%3d" sprintf ;

:: report ( teams -- lines )
    teams values
    [ [ points neg ] [ name>> ] bi 2array ] sort-by
    [ summary ] map
    header prefix ;

:: tally ( rows -- lines )
    H{ } clone :> teams
    f :> left!
    f :> right!
    f :> outcome!

    rows
    [| row |
        row ";" split
        [ first teams [ <team> ] cache left! ]
        [ second teams [ <team> ] cache right! ]
        [ third outcome! ]
        tri

        outcome
        {
            { "win"  [ left [ 1 + ] change-won   drop  right [ 1 + ] change-lost  drop ] }
            { "draw" [ left [ 1 + ] change-drawn drop  right [ 1 + ] change-drawn drop ] }
            { "loss" [ left [ 1 + ] change-lost  drop  right [ 1 + ] change-won   drop ] }
            [ drop ]
        }
        case
    ]
    each

    teams report ;