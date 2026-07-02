module [maximum_value]

Item : { weight : U64, value : U64 }

maximum_value : { items : List Item, maximum_weight : U64 } -> U64
maximum_value = \{ items, maximum_weight } ->
    initial_dp = List.repeat 0 (maximum_weight + 1)
    
    final_dp = List.walk items initial_dp \dp, item ->
        if maximum_weight < item.weight then
            dp
        else
            List.range { start: At item.weight, end: At maximum_weight }
            |> List.reverse
            |> List.walk dp \current_dp, w ->
                current_value = List.get current_dp w |> Result.with_default 0
                previous_weight_value = List.get current_dp (w - item.weight) |> Result.with_default 0
                value_with_item = previous_weight_value + item.value
                new_value = Num.max current_value value_with_item
                List.set current_dp w new_value
    
    List.get final_dp maximum_weight |> Result.with_default 0
    