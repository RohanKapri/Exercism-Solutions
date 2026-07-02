module [tally]

TeamStats : { mp : U32, w : U32, d : U32, l : U32 }

emptyStats : TeamStats
emptyStats = { mp: 0, w: 0, d: 0, l: 0 }

points : TeamStats -> U32
points = |s| s.w * 3 + s.d

formatNum : U32 -> Str
formatNum = |n|
    s = Num.to_str(n)
    if Str.count_utf8_bytes(s) >= 2 then s else Str.concat(" ", s)

formatRowWithLen : Str, U64, TeamStats -> Str
formatRowWithLen = |name, nameLen, s|
    p = points(s)
    padding =
        if nameLen >= 31 then
            ""
        else
            Str.repeat(" ", 31 - nameLen)
    "$(name)$(padding)| $(formatNum(s.mp)) | $(formatNum(s.w)) | $(formatNum(s.d)) | $(formatNum(s.l)) | $(formatNum(p))"

updateDict : Dict Str TeamStats, Str, (TeamStats -> TeamStats) -> Dict Str TeamStats
updateDict = |dict, key, fn|
    current = Dict.get(dict, key) |> Result.with_default(emptyStats)
    Dict.insert(dict, key, fn(current))

parseLines : List Str -> Result (Dict Str TeamStats) Str
parseLines = |lines|
    List.walk_try(lines, Dict.empty({}), |dict, line|
        if Str.is_empty(line) then
            Ok(dict)
        else
            parts = Str.split_on(line, ";")
            when parts is
                [team1, team2, outcome] ->
                    when outcome is
                        "win" ->
                            dict
                            |> updateDict(team1, |s| { s & mp: s.mp + 1, w: s.w + 1 })
                            |> updateDict(team2, |s| { s & mp: s.mp + 1, l: s.l + 1 })
                            |> Ok
                        "loss" ->
                            dict
                            |> updateDict(team1, |s| { s & mp: s.mp + 1, l: s.l + 1 })
                            |> updateDict(team2, |s| { s & mp: s.mp + 1, w: s.w + 1 })
                            |> Ok
                        "draw" ->
                            dict
                            |> updateDict(team1, |s| { s & mp: s.mp + 1, d: s.d + 1 })
                            |> updateDict(team2, |s| { s & mp: s.mp + 1, d: s.d + 1 })
                            |> Ok
                        _ -> Err("Invalid outcome: $(outcome)")
                _ -> Err("Invalid line: $(line)")
    )

compareBytes : List U8, List U8 -> [LT, EQ, GT]
compareBytes = |l1, l2|
    when (l1, l2) is
        ([], []) -> EQ
        ([], _) -> LT
        (_, []) -> GT
        ([b1, .. as rest1], [b2, .. as rest2]) ->
            if b1 < b2 then LT
            else if b1 > b2 then GT
            else compareBytes(rest1, rest2)

header : Str
header = "Team                           | MP |  W |  D |  L |  P"

tally : Str -> Result Str _
tally = |table|
    lines = Str.split_on(table, "\n")
    parseLines(lines)
    |> Result.map_ok(|dict|
        # Pre-compute UTF-8 bytes and byte-length once per team
        # This reduces sort comparisons from 2×N×log(N) to N Str.to_utf8 calls
        decorated =
            Dict.to_list(dict)
            |> List.map(|entry|
                when entry is
                    (name, s) ->
                        bytes = Str.to_utf8(name)
                        { name, s, bytes, nameLen: List.len(bytes) }
            )
            |> List.sort_with(|a, b|
                pa = points(a.s)
                pb = points(b.s)
                if pa != pb then
                    Num.compare(pb, pa)
                else
                    compareBytes(a.bytes, b.bytes)
            )
        rowLines = List.map(decorated, |r| formatRowWithLen(r.name, r.nameLen, r.s))
        # Avoid List.prepend (copies list) — concat header directly onto row string
        rowStr = Str.join_with(rowLines, "\n")
        if List.is_empty(rowLines) then
            header
        else
            "$(header)\n$(rowStr)"
    )
        