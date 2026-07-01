module [slices]

slices : Str, U64 -> List Str
slices = |string, slice_length|
    if slice_length == 0 then
        []
    else
        bytes = Str.to_utf8 string
        len = List.len bytes
        if len == 0 || slice_length > len then
            []
        else
            endExclusive = len - slice_length + 1
            List.range { start: At 0, end: Before endExclusive }
            |> List.map \i ->
                window = bytes |> List.drop_first i |> List.take_first slice_length
                Str.from_utf8 window |> Result.with_default ""
    