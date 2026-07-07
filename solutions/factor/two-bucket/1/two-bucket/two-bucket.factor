USING: combinators kernel locals math math.order math.functions math.order ;
IN: two-bucket

ERROR: goal-not-reachable ;


:: measure-loop ( cap1 cap2 goal name1 name2 content1 content2 moves -- moves goal-bucket other )
    {
        { [ content1 goal = ] [ moves name1 content2 ] }
        { [ content2 goal = ] [ moves name2 content1 ] }
        { [ content1 0 = ] [ cap1 cap2 goal name1 name2 cap1 content2  moves 1 +  measure-loop ] }
        { [ content2 cap2 = ] [ cap1 cap2 goal name1 name2 content1 0  moves 1 +  measure-loop ] }
        [
            content1  cap2 content2 -  min :> transfer
            cap1 cap2 goal name1 name2  content1 transfer -  content2 transfer +  moves 1 +  measure-loop
        ]
    }
    cond ;


:: measure-impl ( cap1 cap2 goal name1 name2 -- moves goal-bucket other )
    goal cap1 >
    goal cap2 >
    and [ goal-not-reachable ] when

    goal
    cap1 cap2 gcd nip
    divisor? [ goal-not-reachable ] unless

    {
        { [ cap1 goal = ] [ 1 name1 0 ] }
        { [ cap2 goal = ] [ 2 name2 cap1 ] }
        [ cap1 cap2 goal name1 name2 0 0 0 measure-loop ]
    }
    cond ;


:: measure ( cap1 cap2 goal start -- moves goal-bucket other )
    start "one" =
    [
        cap1 cap2 goal "one" "two" measure-impl
    ]
    [
        cap2 cap1 goal "two" "one" measure-impl
    ]
    if ;