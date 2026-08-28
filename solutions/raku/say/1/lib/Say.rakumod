constant %single = 0 => Empty,
    ( 1.. 9 Z=> <one two three four five six seven eight nine> );
constant %tenty  =
     10..19 Z=> <ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen>;
constant %tens   =
    (20, 30 ... * ) Z=> <twenty thirty forty fifty sixty seventy eighty ninety>;

constant %one2ninety-nine =
    |%single.sort.skip,
    |%tenty,
    |(%tens X %single).map: { ( map *.key, $_ ).sum => ( map *.value, $_ ).join: '-' };

sub hundreds ( $_ ) {
    when 0     { ''                     }
    when 1..99 { %one2ninety-nine{ $_ } }
    default    { sprintf '%s hundred %s', %one2ninety-nine{ .comb.head }, hundreds .substr: 1 }
}

sub utter ( $_ where ^1e12 ) is export {
    when 0  { 'zero' }
    default {
        trim join ' ', reverse gather
            .take if .head
        for << '' thousand million billion >> RZ, .flip.comb( 3 ).map: { hundreds .flip.Int }
    }
}