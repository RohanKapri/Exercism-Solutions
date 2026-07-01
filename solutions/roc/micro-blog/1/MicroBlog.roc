module [truncate]

import unicode.Grapheme

truncate : Str -> Result Str _
truncate = |input|
    graphemesResult = Grapheme.split input
    when graphemesResult is
        Ok graphemes ->
            truncatedGraphemes = List.take_first graphemes 5
            truncatedStr = Str.join_with truncatedGraphemes ""
            Ok truncatedStr
        Err err -> Err err
    