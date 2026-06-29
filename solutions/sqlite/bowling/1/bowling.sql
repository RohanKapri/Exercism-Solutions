update bowling
set (result, error) = (
    with recursive
    frames as ( -- divides rolls into frames
        select 0 as i, 0 as frame, false as is_first, -1 as pins
        union all
        select i + 1, iif(is_first and pins != 10 and frame <= 10, frame, frame + 1),
            iif(is_first and pins != 10, false, true), previous_rolls->>(i)
        from frames
        where previous_rolls->>i is not null
    ),
    full_frames as ( -- calculate factors to multiply for spares and strikes to following rolls
        select i, frame, pins, ifnull(sum(pins = 10) over prev2, 0) as strike,
            ifnull(sum(pins) over prev1 = 10, false) and ifnull(max(pins) over prev1 != 10, false) as spare
        from frames
        where frame > 0
        window prev2 as (order by i range between 2 preceding and 1 preceding),
            prev1 as (order by i range between 2 preceding and 1 preceding)
    ),
    cleaned_frames as ( -- remove factors of additional throws at game end, special condition for X in F9
        select i, frame, pins, 
            iif(frame > 10, sum(pins) over prev2 = 20 and lead(pins) over next is not null, strike) as strike,
            iif(frame > 10, 0, spare) as spare
        from full_frames
        window prev2 as (order by i range between 2 preceding and 1 preceding),
            next as (order by i)
    ),
    score as ( -- calculate total
        select sum(pins * (1 + strike + spare)) as s
        from cleaned_frames
    ),
    game_done as ( -- check if game is done
        select ifnull(max(frame) = 10 and sum(pins) filter (where frame = 10) != 10
            or max(frame) = 11 and max(pins) filter (where frame = 10) != 10
            or max(frame) = 12, false) as done
        from frames
    ),
    errors as ( -- check all error conditions
        select case
            when roll = -1 then 'Negative roll is invalid'
            when roll > 10 then 'Pin count exceeds pins on the lane'
            when previous_rolls->>-1 != 10 and previous_rolls->>-1 + roll > 10 then 'Pin count exceeds pins on the lane'
            when not done and roll is null then 'Score cannot be taken until the end of the game'
            when done and roll is not null then 'Cannot roll after game is over'
            end as msg
        from game_done
    )
    select iif(msg is null, s, null), msg
    from score, errors
);