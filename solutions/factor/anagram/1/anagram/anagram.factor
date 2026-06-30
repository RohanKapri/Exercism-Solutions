USING: combinators kernel sequences sorting strings unicode ;
IN: anagram

: is-anagram ( candidate subject -- ? )
    [ >upper ] bi@
    2dup =
    [
        2drop f
    ]
    [
        [ sort ] bi@ =
    ]
    if ;

: find-anagrams ( subject candidates -- anagrams )
    swap '[ _ is-anagram ] filter ;