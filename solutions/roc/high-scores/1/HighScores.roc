module [latest, personal_best, personal_top_three]

Score : U64

latest : List Score -> Result Score _
latest = \scores ->
    List.last scores

personal_best : List Score -> Result Score _
personal_best = \scores ->
    List.max scores

personal_top_three : List Score -> List Score
personal_top_three = \scores ->
    scores
    |> List.sort_desc
    |> List.take_first 3
        