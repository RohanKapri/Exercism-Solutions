module [valid]

valid : Str -> Bool
valid = |digits|
    bytes = Str.to_utf8(digits)

    init : Result { count : U32, ep : U32, ed : U32, op_ : U32, od : U32 } {}
    init = Ok({ count: 0, ep: 0, ed: 0, op_: 0, od: 0 })

    result = List.walk(bytes, init, |state, byte|
        when state is
            Err _ -> state
            Ok acc ->
                if byte == ' ' then
                    state
                else if byte < '0' || byte > '9' then
                    Err {}
                else
                    d = Num.to_u32(byte - '0')
                    dbl = if d >= 5 then d * 2 - 9 else d * 2
                    if acc.count % 2 == 0 then
                        Ok { acc & count: acc.count + 1, ep: acc.ep + d, ed: acc.ed + dbl }
                    else
                        Ok { acc & count: acc.count + 1, op_: acc.op_ + d, od: acc.od + dbl }
    )

    when result is
        Err _ -> Bool.false
        Ok { count, ep, ed, op_, od } ->
            if count <= 1 then
                Bool.false
            else
                total = if count % 2 == 0 then ed + op_ else ep + od
                total % 10 == 0
    