module [flatten]

NestedValue : [Value I64, Null, NestedArray (List NestedValue)]

flatten : NestedValue -> List I64
flatten = \nestedValue ->
    flattenHelper nestedValue []

flattenHelper : NestedValue, List I64 -> List I64
flattenHelper = \nestedValue, acc ->
    when nestedValue is
        Value n -> List.append acc n
        Null -> acc
        NestedArray list ->
            List.walk list acc \innerAcc, item ->
                flattenHelper item innerAcc