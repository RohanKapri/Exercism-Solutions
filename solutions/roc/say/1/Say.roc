module [say]

say : U64 -> Result Str [OutOfBounds]
say = \number ->
    if number > 999999999999 then
        Err OutOfBounds
    else if number == 0 then
        Ok "zero"
    else
        Ok (spellNumber number |> Str.trim)

spellNumber : U64 -> Str
spellNumber = \number ->
    if number < 100 then
        spellUnder100 number
    else if number < 1000 then
        spellUnder1000 number
    else
        spellLargeNumber number

spellUnder100 : U64 -> Str
spellUnder100 = \number ->
    when Dict.get smallNumbers number is
        Ok word -> word
        Err KeyNotFound ->
            tensDigit = number // 10
            onesDigit = number % 10
            tensWord = Dict.get tens (tensDigit * 10) |> Result.with_default ""
            
            if onesDigit == 0 then
                tensWord
            else
                onesWord = Dict.get smallNumbers onesDigit |> Result.with_default ""
                "${tensWord}-${onesWord}"

spellUnder1000 : U64 -> Str
spellUnder1000 = \number ->
    hundreds = number // 100
    rest = number % 100
    hundredsWord = Dict.get smallNumbers hundreds |> Result.with_default ""
    
    if rest == 0 then
        "${hundredsWord} hundred"
    else
        restWord = spellUnder100 rest
        "${hundredsWord} hundred ${restWord}"

spellLargeNumber : U64 -> Str
spellLargeNumber = \number ->
    scales
    |> Dict.to_list
    |> List.sort_with \(scale1, _), (scale2, _) -> Num.compare scale2 scale1
    |> List.walk_until "" \acc, (scale, name) ->
        if number >= scale then
            count = number // scale
            rest = number % scale
            countSpelled = spellNumber count
            
            if rest == 0 then
                Break "${countSpelled} ${name}"
            else
                restSpelled = spellNumber rest
                Break "${countSpelled} ${name} ${restSpelled}"
        else
            Continue acc

smallNumbers : Dict U64 Str
smallNumbers =
    Dict.from_list [
        (0, ""), (1, "one"), (2, "two"), (3, "three"), (4, "four"),
        (5, "five"), (6, "six"), (7, "seven"), (8, "eight"), (9, "nine"),
        (10, "ten"), (11, "eleven"), (12, "twelve"), (13, "thirteen"),
        (14, "fourteen"), (15, "fifteen"), (16, "sixteen"), (17, "seventeen"),
        (18, "eighteen"), (19, "nineteen"),
    ]

tens : Dict U64 Str
tens =
    Dict.from_list [
        (20, "twenty"), (30, "thirty"), (40, "forty"), (50, "fifty"),
        (60, "sixty"), (70, "seventy"), (80, "eighty"), (90, "ninety"),
    ]

scales : Dict U64 Str
scales =
    Dict.from_list [
        (1000000000, "billion"),
        (1000000, "million"),
        (1000, "thousand"),
        (1, ""),
    ]
     