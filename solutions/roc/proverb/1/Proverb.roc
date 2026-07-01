module [recite]

recite : List Str -> Str
recite = |items|
    when items is
        [] -> ""
        [first] -> "And all for the want of a ${first}."
        _ ->
            lines = List.map2
                items
                (List.drop_first items 1)
                (\a, b -> "For want of a ${a} the ${b} was lost.")
            conclusion = when List.first items is
                Ok first_item -> "And all for the want of a ${first_item}."
                Err _ -> ""
            Str.join_with (List.concat lines [conclusion]) "\n"
         