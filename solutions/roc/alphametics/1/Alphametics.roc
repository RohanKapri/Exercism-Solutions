module [solve]

parseEquation : Str -> Result { variables : List U8, coefficients : List I64, leadingDigits : List Bool } [NotFound]
parseEquation = \problem ->
    when Str.split_on problem " == " is
        [leftSide, rightSide] ->
            addends = leftSide |> Str.split_on " + " |> List.map Str.to_utf8
            addendEquations = addends |> List.join_map toEq

            sumEquation = rightSide |> Str.to_utf8 |> toEq |> List.map invert

            totalEquation = List.concat addendEquations sumEquation |> merge

            variables = List.map totalEquation .0
            coefficients = List.map totalEquation .1

            leadingAddends = List.keep_oks addends List.first
            leadingSum =
                Str.to_utf8 rightSide
                |> List.first
                |> Result.with_default ' '
            allLeadingChars =
                List.prepend leadingAddends leadingSum
                |> Set.from_list
                |> Set.to_list
            leadingDigits =
                List.map variables \var ->
                    List.contains allLeadingChars var

            Ok { variables, coefficients, leadingDigits }

        _ -> Err NotFound

toEq : List U8 -> List (U8, I64)
toEq = \terms ->
    List.reverse terms
        |> List.map_with_index \char, i ->
            (char, Num.pow_int (Num.to_i64 10) (Num.to_i64 i))

invert : (U8, I64) -> (U8, I64)
invert = \(char, times) -> (char, -times)

merge : List (U8, I64) -> List (U8, I64)
merge = \eqs ->
    vars = List.map eqs .0 |> Set.from_list |> Set.to_list
    List.map vars \var ->
        total =
            (List.keep_if eqs \(char, _) -> char == var)
                |> List.map .1
                |> List.sum
        (var, total)

solve : Str -> Result (List (U8, U8)) [NotFound]
solve = \problem ->
    when parseEquation problem is
        Ok equation ->
            when solveInner equation.coefficients equation.leadingDigits zeroToNine [] is
                Ok assignments ->
                    Ok
                        (List.map2
                            equation.variables
                            assignments
                            \v, a -> (v, Num.to_u8 a))

                Err NotFound -> Err NotFound

        Err NotFound -> Err NotFound

solveInner : List I64, List Bool, List I64, List (I64, I64) -> Result (List I64) [NotFound]
solveInner = \coefficients, leading, options, assignments ->
    when (coefficients, leading) is
        ([], _) ->
            sum =
                assignments
                    |> List.map \(coefficient, value) -> coefficient * value
                    |> List.sum
            when sum is
                0 -> Ok (List.map assignments .1)
                _ -> Err NotFound

        ([nextCoefficient, .. as restCoefficients], [isLeading, .. as restLeading]) ->
            List.walk_until options (Err NotFound) \_, option ->
                remainingOptions = List.keep_if options \o -> o != option
                newAssignments = List.append assignments (nextCoefficient, option)

                if isLeading && option == 0 then
                    Continue (Err NotFound)
                else
                    when solveInner restCoefficients restLeading remainingOptions newAssignments is
                        Err NotFound -> Continue (Err NotFound)
                        Ok solution -> Break (Ok solution)

        _ -> Err NotFound

zeroToNine : List I64
zeroToNine = List.range { start: At 0, end: At 9 }
             