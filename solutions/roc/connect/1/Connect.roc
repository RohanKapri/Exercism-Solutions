module [winner]

Board : List [O, X, Empty]
UnionFind : { parents : List U64, ranks : List U64 }

winner : Str -> Result [PlayerO, PlayerX] _
winner = \board_str ->
    size = board_size board_str
    board = parse_board board_str
    uf = init_union_find board size
    connected_uf = connect_cells board size uf
    if check_win board size O connected_uf then
        Ok PlayerO
    else if check_win board size X connected_uf then
        Ok PlayerX
    else
        Err NotFinished

parse_board : Str -> Board
parse_board = \input ->
    input
    |> Str.to_utf8
    |> List.walk [] \acc, elem ->
        when elem is
            'X' -> List.append acc X
            'O' -> List.append acc O
            '.' -> List.append acc Empty
            _ -> acc

init_union_find : Board, U64 -> UnionFind
init_union_find = \board, _size ->
    len = List.len board
    parents = List.range { start: At 0, end: Before len }
    ranks = List.repeat 0 len
    { parents, ranks }

find : UnionFind, U64 -> (UnionFind, U64)
find = \uf, idx ->
    when List.get uf.parents idx is
        Ok parent if parent == idx -> (uf, idx)
        Ok parent ->
            (updated_uf, root) = find uf parent
            new_parents = List.set updated_uf.parents idx root
            ({ updated_uf & parents: new_parents }, root)
        Err _ -> (uf, idx)

union : UnionFind, U64, U64 -> UnionFind
union = \uf, idx1, idx2 ->
    (uf1, root1) = find uf idx1
    (uf2, root2) = find uf1 idx2
    if root1 != root2 then
        rank1 = List.get uf2.ranks root1 |> Result.with_default 0
        rank2 = List.get uf2.ranks root2 |> Result.with_default 0
        if rank1 < rank2 then
            new_parents = List.set uf2.parents root1 root2
            { uf2 & parents: new_parents }
        else if rank1 > rank2 then
            new_parents = List.set uf2.parents root2 root1
            { uf2 & parents: new_parents }
        else
            new_parents = List.set uf2.parents root2 root1
            new_ranks = List.update uf2.ranks root1 \r -> r + 1
            { parents: new_parents, ranks: new_ranks }
    else
        uf2

get_neighbors : U64, U64, U64 -> List U64
get_neighbors = \idx, size, board_len ->
    row = idx // size
    col = idx % size
    
    []
    |> \list -> if row > 0 then List.append list (idx - size) else list
    |> \list -> if row < (size - 1) && (idx + size) < board_len then List.append list (idx + size) else list
    |> \list -> if col > 0 then List.append list (idx - 1) else list
    |> \list -> if col < (size - 1) && (idx + 1) < board_len then List.append list (idx + 1) else list
    |> \list -> if col > 0 && row < (size - 1) && (idx + size - 1) < board_len then List.append list (idx + size - 1) else list
    |> \list -> if col < (size - 1) && row > 0 && idx >= size then List.append list (idx - size + 1) else list

board_size : Str -> U64
board_size = \str ->
    data = str |> Str.to_utf8
    first_line =
        when List.split_first data '\n' is
            Ok { before } -> before
            Err _ -> data
    (List.len first_line) // 2 + 1

connect_cells : Board, U64, UnionFind -> UnionFind
connect_cells = \board, size, uf ->
    board_len = List.len board
    List.walk_with_index board uf \acc_uf, elem, idx ->
        if elem != Empty then
            neighbors = get_neighbors idx size board_len
            List.walk neighbors acc_uf \inner_uf, neighbor_idx ->
                when List.get board neighbor_idx is
                    Ok neighbor_elem if neighbor_elem == elem ->
                        union inner_uf idx neighbor_idx
                    _ -> inner_uf
        else
            acc_uf

check_win : Board, U64, [O, X, Empty], UnionFind -> Bool
check_win = \board, size, player, uf ->
    start_indices =
        List.range { start: At 0, end: Before size }
        |> List.keep_if \i ->
            idx = if player == O then i else i * size
            when List.get board idx is
                Ok O if player == O -> Bool.true
                Ok X if player == X -> Bool.true
                _ -> Bool.false
    
    end_indices =
        List.range { start: At 0, end: Before size }
        |> List.keep_if \i ->
            idx = if player == O then (size - 1) * size + i else i * size + (size - 1)
            when List.get board idx is
                Ok O if player == O -> Bool.true
                Ok X if player == X -> Bool.true
                _ -> Bool.false
    
    List.any start_indices \start_i ->
        start_idx = if player == O then start_i else start_i * size
        List.any end_indices \end_i ->
            end_idx = if player == O then (size - 1) * size + end_i else end_i * size + (size - 1)
            (_, root_start) = find uf start_idx
            (_, root_end) = find uf end_idx
            root_start == root_end
        