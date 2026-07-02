module [saddle_points]

Forest : List (List U8)
Position : { row : U64, column : U64 }

saddle_points : Forest -> Set Position
saddle_points = \tree_heights ->
    if List.is_empty tree_heights || List.is_empty (List.first tree_heights |> Result.with_default []) then
        Set.empty {}
    else
        cols = List.len (List.first tree_heights |> Result.with_default [])
        
        # Precompute row maximums
        row_maxes = List.map tree_heights (\row -> 
            List.max row |> Result.with_default 0
        )
        
        # Precompute column minimums
        col_mins = List.range { start: At 0, end: Before cols }
            |> List.map (\col -> 
                tree_heights
                    |> List.map (\row -> List.get row col |> Result.with_default 0)
                    |> find_min
            )
        
        # Find all saddle points
        tree_heights
            |> List.walk_with_index (Set.empty {}) \acc_set, row, row_index ->
                row
                    |> List.walk_with_index acc_set \inner_acc_set, height, col_index ->
                        row_max = List.get row_maxes row_index |> Result.with_default 0
                        col_min = List.get col_mins col_index |> Result.with_default 255
                        
                        if height == row_max && height == col_min then
                            Set.insert inner_acc_set { 
                                row: Num.to_u64 (row_index + 1), 
                                column: Num.to_u64 (col_index + 1) 
                            }
                        else
                            inner_acc_set

# Helper function to find minimum in a list
find_min : List U8 -> U8
find_min = \list ->
    if List.is_empty list then
        crash "Cannot find min of empty list"
    else
        list
            |> List.walk (List.first list |> Result.with_default 0) \min_so_far, value ->
                if value < min_so_far then value else min_so_far
        