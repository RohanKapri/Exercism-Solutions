module [grep]

import "iliad.txt" as iliad : Str
import "midsummer-night.txt" as midsummer_night : Str
import "paradise-lost.txt" as paradise_lost : Str

MatchCfg : { i : Bool, v : Bool, x : Bool }

grep : Str, List Str, List Str -> Result Str Str
grep = |pattern, flagList, files|
    opts =
        {
            n: List.contains(flagList, "-n"),
            l: List.contains(flagList, "-l"),
            i: List.contains(flagList, "-i"),
            v: List.contains(flagList, "-v"),
            x: List.contains(flagList, "-x"),
        }
    mc = { i: opts.i, v: opts.v, x: opts.x }
    ## Normalized needle once (-i ⇒ lower-cased ASCII pattern; else raw pattern).
    needle = pattern_norm(pattern, mc.i)
    multi = List.len(files) > 1
    if opts.l then
        names =
            List.walk_try(files, [], |acc, fname|
                when resolve fname is
                    Err(msg) -> Err(msg)
                    Ok(text) ->
                        lines = Str.split_on(text, "\n")
                        if file_has_any_match(lines, needle, mc) then
                            Ok(List.append(acc, fname))
                        else
                            Ok(acc),
            )
        Result.map_ok(names, |pieces| Str.join_with(pieces, "\n"))
    else
        ## Per-file chunks with prepend
        segments =
            List.walk_try(files, [], |acc_segments, fname|
                when resolve fname is
                    Err(msg) -> Err(msg)
                    Ok(text) ->
                        lines = Str.split_on(text, "\n")
                        chunk = format_matching_lines(fname, lines, needle, opts, mc, multi)
                        Ok(List.prepend(acc_segments, chunk)),
            )

        Result.map_ok(segments, |chunks_rev|
            chunks_rev
            |> List.reverse
            |> List.join
            |> Str.join_with("\n"),
        )

resolve : Str -> Result Str Str
resolve = |name|
    if name == "iliad.txt" then
        Ok(iliad)
    else if name == "midsummer-night.txt" then
        Ok(midsummer_night)
    else if name == "paradise-lost.txt" then
        Ok(paradise_lost)
    else
        Err("unknown file")

ascii_lower_utf8 : U8 -> U8
ascii_lower_utf8 = |b|
    if b >= 'A' && b <= 'Z' then b + 32 else b

lower_str : Str -> Str
lower_str = |s|
    s |> Str.to_utf8 |> List.map(ascii_lower_utf8) |> Str.from_utf8 |> Result.with_default("")

pattern_norm : Str, Bool -> Str
pattern_norm = |p, insensitive|
    if insensitive then lower_str(p) else p

## `needle` is already pattern_norm(pattern, cfg.i)
matches_line : Str, Str, MatchCfg -> Bool
matches_line = |line, needle, cfg|
    line_n =
        if cfg.i then lower_str(line) else line

    matched =
        if cfg.x then
            line_n == needle
        else
            Str.contains(line_n, needle)

    if cfg.v then !matched else matched

file_has_any_match : List Str, Str, MatchCfg -> Bool
file_has_any_match = |lines, needle, cfg|
    List.any(lines, |ln| matches_line(ln, needle, cfg))

format_matching_lines : Str, List Str, Str, { n : Bool, l : Bool, i : Bool, v : Bool, x : Bool }, MatchCfg, Bool -> List Str
format_matching_lines = |fname, lines, needle, opts, mc, multi|
    rev =
        List.walk_with_index(lines, [], |acc, ln, ix|
            if matches_line(ln, needle, mc) then
                built =
                    if multi then
                        if opts.n then
                            "$(fname):$(Num.to_str(ix + 1)):$(ln)"
                        else
                            "$(fname):$(ln)"
                    else if opts.n then
                        "$(Num.to_str(ix + 1)):$(ln)"
                    else
                        ln

                List.prepend(acc, built)
            else
                acc,
        )

    List.reverse(rev)
                        