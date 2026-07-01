module [transform]

transform : Dict U64 (List U8) -> Dict U8 U64
transform = \legacy ->
    Dict.walk legacy (Dict.empty {}) \acc, score, letters ->
        List.walk letters acc \innerAcc, letter ->
            Dict.insert innerAcc (Num.bitwise_or letter 0b00100000) score
    