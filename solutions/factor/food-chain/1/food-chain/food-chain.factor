USING: arrays combinators formatting kernel locals math math.order ranges sequences ;
IN: food-chain


CONSTANT: animals { f "fly" "spider" "bird" "cat" "dog" "goat" "cow" "horse" }


CONSTANT: exclamations { f "I don't know why she swallowed the fly. Perhaps she'll die." "It wriggled and jiggled and tickled inside her." "How absurd to swallow a bird!" "Imagine that, to swallow a cat!" "What a hog, to swallow a dog!" "Just opened her throat and swallowed a goat!" "I don't know how she swallowed a cow!" "She's dead, of course!" }


:: food-chain-verse ( verse dest -- )
    verse animals nth
    "I know an old lady who swallowed a %s." sprintf  dest push
    verse exclamations nth  dest push

    verse 2 7 between?
    [
        verse 2 [a..b]
        [| i |
            i animals nth
            i 1 - animals nth
            i 3 = [ " that wriggled and jiggled and tickled inside her" ] [ "" ] if
            "She swallowed the %s to catch the %s%s." sprintf  dest push
        ]
        each

        1 exclamations nth  dest push
    ]
    when ;


:: food-chain ( start end -- lines )
    V{ } clone :> result

    start end
    [a..b)
    [| verse |
        verse result food-chain-verse
        "" result push
    ]
    each

    end result food-chain-verse
    result >array ;