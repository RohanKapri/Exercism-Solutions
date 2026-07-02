module [find_fewest_coins]

Queue : { front : List U64, back : List U64 }

find_fewest_coins : List U64, U64 -> Result (List U64) _
find_fewest_coins = |coins, target|
    if target == 0 then
        Ok []
    else
        valid_coins =
            coins
                |> List.keep_if(\coin -> coin > 0 && coin <= target)
                |> Set.from_list
                |> Set.to_list

        if List.is_empty valid_coins then
            Err "no solution"
        else
            queue = { front: [0], back: [] }
            visited = Set.from_list [0]
            prev = Dict.empty({})

            when bfs queue visited prev valid_coins target is
                Ok coin_list ->
                    Ok (List.sort_with(coin_list, \a, b -> Num.compare(a, b)))

                Err err ->
                    Err err

bfs : Queue, Set U64, Dict U64 { prev : U64, coin : U64 }, List U64, U64 -> Result (List U64) Str
bfs = \queue, visited, prev, coins, target ->
    when dequeue queue is
        Err _ ->
            Err "no solution"

        Ok { value, queue: next_queue } ->
            when explore coins value next_queue visited prev target is
                Found result ->
                    Ok result

                Continue { queue: q2, visited: v2, prev: p2 } ->
                    bfs q2 v2 p2 coins target

ExploreResult : [Found (List U64), Continue { queue : Queue, visited : Set U64, prev : Dict U64 { prev : U64, coin : U64 } }]

explore : List U64, U64, Queue, Set U64, Dict U64 { prev : U64, coin : U64 }, U64 -> ExploreResult
explore = \coins, current, queue, visited, prev, target ->
    when coins is
        [] ->
            Continue { queue, visited, prev }

        [coin, .. as rest] ->
            next = current + coin

            if next > target || Set.contains visited next then
                explore rest current queue visited prev target
            else
                visited2 = Set.insert visited next
                prev2 = Dict.insert prev next { prev: current, coin }

                if next == target then
                    Found (reconstruct prev2 target)
                else
                    queue2 = enqueue queue next
                    explore rest current queue2 visited2 prev2 target

reconstruct : Dict U64 { prev : U64, coin : U64 }, U64 -> List U64
reconstruct = \prev, node ->
    if node == 0 then
        []
    else
        when Dict.get prev node is
            Ok { prev: p, coin: c } ->
                List.prepend (reconstruct prev p) c

            Err _ ->
                []

enqueue : Queue, U64 -> Queue
enqueue = \queue, value ->
    { queue & back: List.prepend(queue.back, value) }

dequeue : Queue -> Result { value : U64, queue : Queue } Str
dequeue = \queue ->
    when queue.front is
        [value, .. as rest] ->
            Ok { value, queue: { front: rest, back: queue.back } }

        [] ->
            when queue.back is
                [] ->
                    Err "empty"

                _ ->
                    new_front = List.reverse queue.back

                    when new_front is
                        [] -> Err "empty"
                        [value, .. as rest] ->
                            Ok { value, queue: { front: rest, back: [] } }