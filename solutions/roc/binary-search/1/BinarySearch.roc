module [find]

find : List U64, U64 -> Result U64 _
find = |array, value|
    len = List.len(array)

    search = |left, rightExclusive|
        if left >= rightExclusive then
            Err {}
        else
            mid = left + ((rightExclusive - left) // 2)

            when List.get(array, mid) is
                Err _ ->
                    Err {}

                Ok(candidate) ->
                    if candidate == value then
                        Ok(mid)
                    else if candidate > value then
                        search(left, mid)
                    else
                        search(mid + 1, rightExclusive)

    search(0, len)
                        