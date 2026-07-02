module [measure]

State : { a : U64, b : U64 }
BfsEntry : { state : State, moves : U64 }

measure :
    { bucket_one : U64, bucket_two : U64, goal : U64, start_bucket : [One, Two] }
    ->
    Result { moves : U64, goal_bucket : [One, Two], other_bucket : U64 } _
measure = |{ bucket_one, bucket_two, goal, start_bucket }|
    if goal > bucket_one && goal > bucket_two then
        Err(GoalImpossible)
    else
        stride = bucket_two + 1

        forbidden_idx =
            when start_bucket is
                One -> bucket_two          # (a=0, b=cap2)
                Two -> bucket_one * stride # (a=cap1, b=0)

        init_a =
            when start_bucket is
                One -> bucket_one
                Two -> 0u64
        init_b =
            when start_bucket is
                One -> 0u64
                Two -> bucket_two

        init_idx = init_a * stride + init_b
        visited_size = (bucket_one + 1) * stride
        visited = List.set(List.repeat(Bool.false, visited_size), init_idx, Bool.true)
        queue = [{ state: { a: init_a, b: init_b }, moves: 1u64 }]

        bfs_loop(queue, visited, bucket_one, bucket_two, stride, goal, forbidden_idx)

bfs_loop :
    List BfsEntry,
    List Bool,
    U64,
    U64,
    U64,
    U64,
    U64
    ->
    Result { moves : U64, goal_bucket : [One, Two], other_bucket : U64 } _
bfs_loop = |queue, visited, cap1, cap2, stride, goal, forbidden_idx|
    when queue is
        [] -> Err(NoSolution)
        [{ state: { a, b }, moves }, .. as rest] ->
            if a == goal then
                Ok({ moves, goal_bucket: One, other_bucket: b })
            else if b == goal then
                Ok({ moves, goal_bucket: Two, other_bucket: a })
            else
                nm = moves + 1
                poured_ab = Num.min(a, cap2 - b)
                poured_ba = Num.min(b, cap1 - a)

                candidates = [
                    { a: cap1, b },
                    { a, b: cap2 },
                    { a: 0, b },
                    { a, b: 0 },
                    { a: a - poured_ab, b: b + poured_ab },
                    { a: a + poured_ba, b: b - poured_ba },
                ]

                { nq, nv } = List.walk(
                    candidates,
                    { nq: rest, nv: visited },
                    |acc, next|
                        idx = next.a * stride + next.b
                        already =
                            when List.get(acc.nv, idx) is
                                Ok(v) -> v
                                Err(_) -> Bool.true
                        if already || idx == forbidden_idx then
                            acc
                        else
                            {
                                nq: List.append(acc.nq, { state: next, moves: nm }),
                                nv: List.set(acc.nv, idx, Bool.true),
                            },
                )

                bfs_loop(nq, nv, cap1, cap2, stride, goal, forbidden_idx)