module [plants]

Student : [Alice, Bob, Charlie, David, Eve, Fred, Ginny, Harriet, Ileana, Joseph, Kincaid, Larry]
Plant : [Grass, Clover, Radishes, Violets]

plants : Str, Student -> Result (List Plant) _
plants = \diagram, student ->
    diagram
        |> Str.trim
        |> Str.split_on "\n"
        |> List.map Str.trim
        |> List.keep_if (\s -> Bool.not (Str.is_empty s))
        |> \rows ->
            when rows is
                [row1, row2] ->
                    plants1Result = parseRow row1
                    plants2Result = parseRow row2
                    
                    if Result.is_ok plants1Result && Result.is_ok plants2Result then
                        plants1 = Result.with_default plants1Result []
                        plants2 = Result.with_default plants2Result []
                        idx = studentIndex student
                        
                        Ok (List.concat
                            (List.sublist plants1 { start: idx * 2, len: 2 })
                            (List.sublist plants2 { start: idx * 2, len: 2 }))
                    else
                        Err "Invalid plant character"
                _ -> Err "Invalid diagram"

parseRow : Str -> Result (List Plant) _
parseRow = \row ->
    chars = Str.to_utf8 row
    plantResults = List.map chars charToPlant
    
    # Check if all conversions were successful
    if List.all plantResults Result.is_ok then
        Ok (List.map plantResults (\p -> Result.with_default p Grass))
    else
        Err "Invalid plant character"

charToPlant : U8 -> Result Plant _
charToPlant = \char ->
    when char is
        71 -> Ok Grass     # 'G'
        67 -> Ok Clover    # 'C'
        82 -> Ok Radishes  # 'R'
        86 -> Ok Violets   # 'V'
        _ -> Err "Invalid plant"

studentIndex : Student -> U64
studentIndex = \student ->
    when student is
        Alice -> 0
        Bob -> 1
        Charlie -> 2
        David -> 3
        Eve -> 4
        Fred -> 5
        Ginny -> 6
        Harriet -> 7
        Ileana -> 8
        Joseph -> 9
        Kincaid -> 10
        Larry -> 11
                