module [territory, territories]

Intersection : { x : U64, y : U64 }

Stone : [White, Black, None]

Territory : {
    owner : Stone,
    territory : Set Intersection,
}

Territories : {
    black : Set Intersection,
    white : Set Intersection,
    none : Set Intersection,
}

## Flat board representation: a single list of U8 values plus dimensions.
## 0 = empty, 1 = Black, 2 = White
## This avoids the double-indirection of List (List Stone) and enables
## fast indexing via y * width + x.
Board : { cells : List U8, width : U64, height : U64 }

## Parse the board string into a flat array representation.
parse_board : Str -> Board
parse_board = |board_str|
    bytes = Str.to_utf8(board_str)
    # First pass: find the width from the first line
    width = find_line_width(bytes, 0)
    # Single pass: build flat cells list, skipping newlines
    { cells, height } = build_cells(bytes, width)
    { cells, width, height }

find_line_width : List U8, U64 -> U64
find_line_width = |bytes, idx|
    when List.get(bytes, idx) is
        Ok(ch) ->
            if ch == '\n' then
                idx
            else
                find_line_width(bytes, idx + 1)
        Err(_) ->
            # No newline found — the entire bytes is a single line
            List.len(bytes)

build_cells : List U8, U64 -> { cells : List U8, height : U64 }
build_cells = |bytes, width|
    total = List.len(bytes)
    estimated_rows = if total > 0 then (total + 1) // (width + 1) else 0
    capacity = estimated_rows * width
    List.walk(bytes, { cells: List.with_capacity(capacity), height: 0, col: 0u64 }, |state, ch|
        if ch == '\n' then
            if state.col > 0 then
                { state & height: state.height + 1, col: 0 }
            else
                state
        else
            cell =
                when ch is
                    'B' -> 1u8
                    'W' -> 2u8
                    _ -> 0u8
            { state & cells: List.append(state.cells, cell), col: state.col + 1 }
    )
    |> |final_state|
        # Handle last line if no trailing newline
        if final_state.col > 0 then
            { cells: final_state.cells, height: final_state.height + 1 }
        else
            { cells: final_state.cells, height: final_state.height }

## Get the cell value at (x, y). Returns 0/1/2.
get_cell : Board, U64, U64 -> U8
get_cell = |board, x, y|
    idx = y * board.width + x
    when List.get(board.cells, idx) is
        Ok(v) -> v
        Err(_) -> 0

## BFS flood-fill using a flat List Bool as visited array and index-based queue.
flood_fill : Board, U64, U64 -> { region : List Intersection, has_black : Bool, has_white : Bool }
flood_fill = |board, start_x, start_y|
    total = board.width * board.height
    start_idx = start_y * board.width + start_x
    initial_visited = List.set(List.repeat(Bool.false, total), start_idx, Bool.true)
    initial_queue = [{ x: start_x, y: start_y }]

    bfs_loop(
        board,
        initial_queue,
        0, # queue head pointer
        initial_visited,
        [{ x: start_x, y: start_y }], # region collector
        Bool.false, # has_black
        Bool.false, # has_white
    )

bfs_loop : Board, List Intersection, U64, List Bool, List Intersection, Bool, Bool -> { region : List Intersection, has_black : Bool, has_white : Bool }
bfs_loop = |board, queue, head, visited, region, has_black, has_white|
    if head >= List.len(queue) then
        { region, has_black, has_white }
    else
        # O(1) dequeue via index
        current =
            when List.get(queue, head) is
                Ok(c) -> c
                Err(_) -> { x: 0, y: 0 } # unreachable
        new_head = head + 1
        cx = current.x
        cy = current.y
        w = board.width

        # Process all 4 neighbors inline (no list allocation for neighbors)
        s1 = { q: queue, v: visited, r: region, hb: has_black, hw: has_white }
        s2 = if cx > 0 then process_neighbor(board, cx - 1, cy, w, s1) else s1
        s3 = if cx + 1 < board.width then process_neighbor(board, cx + 1, cy, w, s2) else s2
        s4 = if cy > 0 then process_neighbor(board, cx, cy - 1, w, s3) else s3
        s5 = if cy + 1 < board.height then process_neighbor(board, cx, cy + 1, w, s4) else s4

        bfs_loop(board, s5.q, new_head, s5.v, s5.r, s5.hb, s5.hw)

process_neighbor : Board, U64, U64, U64, { q : List Intersection, v : List Bool, r : List Intersection, hb : Bool, hw : Bool } -> { q : List Intersection, v : List Bool, r : List Intersection, hb : Bool, hw : Bool }
process_neighbor = |board, nx, ny, w, state|
    cell = get_cell(board, nx, ny)
    if cell == 1 then
        { state & hb: Bool.true }
    else if cell == 2 then
        { state & hw: Bool.true }
    else
        nbr_idx = ny * w + nx
        already_visited =
            when List.get(state.v, nbr_idx) is
                Ok(b) -> b
                Err(_) -> Bool.true
        if already_visited then
            state
        else
            nbr = { x: nx, y: ny }
            {
                q: List.append(state.q, nbr),
                v: List.set(state.v, nbr_idx, Bool.true),
                r: List.append(state.r, nbr),
                hb: state.hb,
                hw: state.hw,
            }

## Determine the owner from border flags.
determine_owner : Bool, Bool -> Stone
determine_owner = |has_black, has_white|
    if has_black && has_white then
        None
    else if has_black then
        Black
    else if has_white then
        White
    else
        None

territory : Str, Intersection -> Result Territory _
territory = |board_str, { x, y }|
    board = parse_board(board_str)

    if x >= board.width || y >= board.height then
        Err(InvalidCoordinate)
    else
        cell = get_cell(board, x, y)
        if cell != 0 then
            Ok({ owner: None, territory: Set.empty({}) })
        else
            { region, has_black, has_white } = flood_fill(board, x, y)
            owner = determine_owner(has_black, has_white)
            Ok({ owner, territory: Set.from_list(region) })

territories : Str -> Result Territories _
territories = |board_str|
    board = parse_board(board_str)
    total = board.width * board.height

    # Use a flat boolean array for global visited tracking
    initial_visited = List.repeat(Bool.false, total)

    y_range = List.range({ start: At(0), end: Before(board.height) })

    result = List.walk(y_range, { black: [], white: [], none_list: [], visited: initial_visited }, |state, y|
        x_range = List.range({ start: At(0), end: Before(board.width) })
        List.walk(x_range, state, |inner_state, x|
            idx = y * board.width + x
            already_visited =
                when List.get(inner_state.visited, idx) is
                    Ok(b) -> b
                    Err(_) -> Bool.true
            if already_visited then
                inner_state
            else
                cell = get_cell(board, x, y)
                if cell != 0 then
                    { inner_state & visited: List.set(inner_state.visited, idx, Bool.true) }
                else
                    { region, has_black, has_white } = flood_fill(board, x, y)
                    owner = determine_owner(has_black, has_white)
                    # Mark all region cells as visited in the flat array
                    new_visited = List.walk(region, inner_state.visited, |v, pos|
                        List.set(v, pos.y * board.width + pos.x, Bool.true)
                    )
                    when owner is
                        Black ->
                            { inner_state & black: List.concat(inner_state.black, region), visited: new_visited }
                        White ->
                            { inner_state & white: List.concat(inner_state.white, region), visited: new_visited }
                        None ->
                            { inner_state & none_list: List.concat(inner_state.none_list, region), visited: new_visited }
        )
    )

    Ok({ black: Set.from_list(result.black), white: Set.from_list(result.white), none: Set.from_list(result.none_list) })