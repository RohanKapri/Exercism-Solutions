module [Game, create, roll, score]

Game := {
    rolls_packed : U128,  ## up to 21 rolls stored as 4-bit nibbles
    roll_count   : U8,
    frame        : U8,
    roll_in_frame: U8,
    frame_roll1  : U8,
    frame_roll2  : U8,
    is_complete  : Bool,
}

## Retrieve roll i from a packed U128.
get_roll : U128, U8 -> U64
get_roll = |packed, i|
    shift : U8
    shift = i * 4
    Num.to_u64(Num.bitwise_and(Num.shift_right_by(packed, shift), 0xF))

## Store value v at position i in packed U128.
set_roll : U128, U8, U64 -> U128
set_roll = |packed, i, v|
    shift : U8
    shift = i * 4
    Num.bitwise_or(packed, Num.shift_left_by(Num.to_u128(v), shift))

StateRec : { frame : U8, roll_in_frame : U8, frame_roll1 : U8, frame_roll2 : U8, is_complete : Bool }

apply_roll_state : StateRec, U64 -> Result StateRec _
apply_roll_state = |s, pins|
    if s.is_complete then
        Err(GameAlreadyOver)
    else if pins > 10 then
        Err(InvalidPin)
    else
        p = Num.to_u8(pins)
        if s.frame < 9 then
            if s.roll_in_frame == 0 then
                if pins == 10 then
                    Ok({ s & frame: s.frame + 1, roll_in_frame: 0, frame_roll1: 0 })
                else
                    Ok({ s & roll_in_frame: 1, frame_roll1: p })
            else
                if Num.to_u64(s.frame_roll1) + pins > 10 then
                    Err(InvalidPinCount)
                else
                    Ok({ s & frame: s.frame + 1, roll_in_frame: 0, frame_roll1: 0 })
        else
            if s.roll_in_frame == 0 then
                Ok({ s & roll_in_frame: 1, frame_roll1: p })
            else if s.roll_in_frame == 1 then
                r1 = Num.to_u64(s.frame_roll1)
                if r1 == 10 then
                    Ok({ s & roll_in_frame: 2, frame_roll2: p })
                else if r1 + pins > 10 then
                    Err(InvalidPinCount)
                else if r1 + pins == 10 then
                    Ok({ s & roll_in_frame: 2, frame_roll2: p })
                else
                    Ok({ s & is_complete: Bool.true })
            else
                r1 = Num.to_u64(s.frame_roll1)
                r2 = Num.to_u64(s.frame_roll2)
                if r1 == 10 then
                    if r2 == 10 then
                        Ok({ s & is_complete: Bool.true })
                    else
                        if r2 + pins > 10 then
                            Err(InvalidPinCount)
                        else
                            Ok({ s & is_complete: Bool.true })
                else
                    Ok({ s & is_complete: Bool.true })

init_state : StateRec
init_state = { frame: 0, roll_in_frame: 0, frame_roll1: 0, frame_roll2: 0, is_complete: Bool.false }

## Replay a list of U64 rolls into (packed, count, state).
replay : List U64 -> Result { packed : U128, count : U8, state : StateRec } _
replay = |rolls|
    start = { packed: 0, count: 0, state: init_state }
    List.walk_try(
        rolls,
        start,
        |acc, pins|
            new_state = apply_roll_state(acc.state, pins)?
            new_packed = set_roll(acc.packed, acc.count, pins)
            Ok({ packed: new_packed, count: acc.count + 1, state: new_state }),
    )

create : { previous_rolls ?? List U64 } -> Result Game _
create = |{ previous_rolls ?? [] }|
    r = replay(previous_rolls)?
    Ok(
        @Game({
            rolls_packed  : r.packed,
            roll_count    : r.count,
            frame         : r.state.frame,
            roll_in_frame : r.state.roll_in_frame,
            frame_roll1   : r.state.frame_roll1,
            frame_roll2   : r.state.frame_roll2,
            is_complete   : r.state.is_complete,
        }),
    )

roll : Game, U64 -> Result Game _
roll = |game, pins|
    @Game({ rolls_packed, roll_count, frame, roll_in_frame, frame_roll1, frame_roll2, is_complete }) = game
    s = { frame, roll_in_frame, frame_roll1, frame_roll2, is_complete }
    new_s = apply_roll_state(s, pins)?
    Ok(
        @Game({
            rolls_packed  : set_roll(rolls_packed, roll_count, pins),
            roll_count    : roll_count + 1,
            frame         : new_s.frame,
            roll_in_frame : new_s.roll_in_frame,
            frame_roll1   : new_s.frame_roll1,
            frame_roll2   : new_s.frame_roll2,
            is_complete   : new_s.is_complete,
        }),
    )

score : Game -> Result U64 _
score = |finished_game|
    @Game({ rolls_packed, is_complete }) = finished_game
    if is_complete then
        Ok(score_frames(rolls_packed, 0, 0, 0))
    else
        Err(GameNotComplete)

## Scorer over packed rolls
score_frames : U128, U64, U64, U64 -> U64
score_frames = |packed, frame, idx, acc|
    if frame == 10 then
        acc
    else if frame == 9 then
        r1 = get_roll(packed, Num.to_u8(idx))
        r2 = get_roll(packed, Num.to_u8(idx + 1))
        r3 = get_roll(packed, Num.to_u8(idx + 2))
        acc + r1 + r2 + r3
    else
        r1 = get_roll(packed, Num.to_u8(idx))
        if r1 == 10 then
            r2 = get_roll(packed, Num.to_u8(idx + 1))
            r3 = get_roll(packed, Num.to_u8(idx + 2))
            score_frames(packed, frame + 1, idx + 1, acc + 10 + r2 + r3)
        else
            r2 = get_roll(packed, Num.to_u8(idx + 1))
            if r1 + r2 == 10 then
                r3 = get_roll(packed, Num.to_u8(idx + 2))
                score_frames(packed, frame + 1, idx + 2, acc + 10 + r3)
            else
                score_frames(packed, frame + 1, idx + 2, acc + r1 + r2)
           