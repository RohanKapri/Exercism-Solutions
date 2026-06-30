USING: arrays formatting grouping kernel locals math sequences ;
IN: proverb

:: recite ( strings -- lines )
    V{ } clone :> result

    strings 2 <clumps>
    [
        [ first ] [ second ] bi "For want of a %s the %s was lost." sprintf
        result push
    ]
    each

    strings empty?
    [
        strings first "And all for the want of a %s." sprintf
        result push
    ]
    unless

    result >array ;