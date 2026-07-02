module [evaluate, EvalError]

EvalError : [
    UnknownIdentifier Str,
    DivisionByZero,
    StackUnderflow,
]

Op : [
    Push I16,
    Add,
    Sub,
    Mul,
    Div,
    Dup,
    Drop,
    Swap,
    Over,
]

Stack : List I16

evaluate : Str -> Result Stack EvalError
evaluate = |program|
    tokens = tokenize(program)
    step(tokens, 0, default_env, [])

default_env : Dict Str (List Op)
default_env =
    Dict.from_list(
        [
            ("+", [Add]),
            ("-", [Sub]),
            ("*", [Mul]),
            ("/", [Div]),
            ("dup", [Dup]),
            ("drop", [Drop]),
            ("swap", [Swap]),
            ("over", [Over]),
        ],
    )

tokenize : Str -> List Str
tokenize = |raw|
    raw
    |> lowercase
    |> Str.replace_each("\r", " ")
    |> Str.replace_each("\n", " ")
    |> Str.replace_each("\t", " ")
    |> Str.split_on(" ")
    |> List.keep_if(|w| Bool.not(Str.is_empty(w)))

ascii_lower_utf8 : U8 -> U8
ascii_lower_utf8 = |b|
    if b >= 'A' && b <= 'Z' then b + 32 else b

lower_key : Str -> Str
lower_key = |s|
    s
    |> Str.to_utf8
    |> List.map(ascii_lower_utf8)
    |> Str.from_utf8
    |> Result.with_default("")

step : List Str, U64, Dict Str (List Op), Stack -> Result Stack EvalError
step = |ts, i, env, stk|
    if i >= List.len(ts) then
        Ok(stk)
    else
        when List.get(ts, i) is
            Err(_) ->
                Err(UnknownIdentifier("program"))
            Ok(tok) ->
                if tok == ":" then
                    when List.get(ts, i + 1) is
                        Err(_) ->
                            Err(UnknownIdentifier("definition"))
                        Ok(name) ->
                            when find_semi(ts, i + 2) is
                                Err(_) ->
                                    Err(UnknownIdentifier(";"))
                                Ok(j) ->
                                    if is_number_token(name) then
                                        Err(UnknownIdentifier(name))
                                    else
                                        body = sublist(ts, i + 2, j)
                                        when compile_all(body, env) is
                                            Err(e) ->
                                                Err(e)
                                            Ok(ops) ->
                                                new_env = Dict.insert(env, lower_key(name), ops)
                                                step(ts, j + 1, new_env, stk)
                else
                    when Str.to_i16(tok) is
                        Ok(num) ->
                            step(ts, i + 1, env, List.append(stk, num))
                        Err(_) ->
                            key = lower_key(tok)
                            when Dict.get(env, key) is
                                Err(_) ->
                                    Err(UnknownIdentifier(tok))
                                Ok(ops) ->
                                    when exec(ops, stk) is
                                        Err(e) ->
                                            Err(e)
                                        Ok(stk2) ->
                                            step(ts, i + 1, env, stk2)

is_number_token : Str -> Bool
is_number_token = |t|
    Result.is_ok(Str.to_i16(t))

find_semi : List Str, U64 -> Result U64 Str
find_semi = |ts, j|
    if j >= List.len(ts) then
        Err("missing ';'")
    else
        when List.get(ts, j) is
            Err(_) ->
                Err("missing ';'")
            Ok(t) ->
                if t == ";" then
                    Ok(j)
                else
                    find_semi(ts, j + 1)

sublist : List Str, U64, U64 -> List Str
sublist = |xs, from, to_exclusive|
    span = to_exclusive - from
    if span <= 0 then
        []
    else
        List.take_first(List.drop_first(xs, from), span)

compile_all : List Str, Dict Str (List Op) -> Result (List Op) EvalError
compile_all = |toks, env|
    List.walk_try(
        toks,
        [],
        |acc, tok|
            when compile_token(tok, env) is
                Err(e) ->
                    Err(e)
                Ok(chunk) ->
                    Ok(List.concat(acc, chunk)),
    )

compile_token : Str, Dict Str (List Op) -> Result (List Op) EvalError
compile_token = |tok, env|
    when Str.to_i16(tok) is
        Ok(n) ->
            Ok([Push(n)])
        Err(_) ->
            key = lower_key(tok)
            when Dict.get(env, key) is
                Err(_) ->
                    Err(UnknownIdentifier(tok))
                Ok(ops) ->
                    Ok(ops)

exec : List Op, Stack -> Result Stack EvalError
exec = |ops, stack|
    List.walk_try(
        ops,
        stack,
        |stk, op|
            when op is
                Push(n) ->
                    Ok(List.append(stk, n))
                Add ->
                    when pop_pair(stk) is
                        Err(e) ->
                            Err(e)
                        Ok((rest, below, top)) ->
                            Ok(List.append(rest, below + top))
                Sub ->
                    when pop_pair(stk) is
                        Err(e) ->
                            Err(e)
                        Ok((rest, below, top)) ->
                            Ok(List.append(rest, below - top))
                Mul ->
                    when pop_pair(stk) is
                        Err(e) ->
                            Err(e)
                        Ok((rest, below, top)) ->
                            Ok(List.append(rest, below * top))
                Div ->
                    when pop_pair(stk) is
                        Err(e) ->
                            Err(e)
                        Ok((rest, below, top)) ->
                            if top == 0 then
                                Err(DivisionByZero)
                            else
                                Ok(List.append(rest, below // top))
                Dup ->
                    when List.last(stk) is
                        Err(_) ->
                            Err(StackUnderflow)
                        Ok(x) ->
                            Ok(List.append(stk, x))
                Drop ->
                    if List.len(stk) < 1 then
                        Err(StackUnderflow)
                    else
                        Ok(List.drop_last(stk, 1))
                Swap ->
                    when swap_top_two(stk) is
                        Err(e) ->
                            Err(e)
                        Ok(s2) ->
                            Ok(s2)
                Over ->
                    len = List.len(stk)
                    if len < 2 then
                        Err(StackUnderflow)
                    else
                        when List.get(stk, len - 2) is
                            Err(_) ->
                                Err(StackUnderflow)
                            Ok(copy) ->
                                Ok(List.append(stk, copy)),
    )

pop_pair : Stack -> Result (Stack, I16, I16) EvalError
pop_pair = |stk|
    if List.len(stk) < 2 then
        Err(StackUnderflow)
    else
        pair = List.take_last(stk, 2)
        when pair is
            [below, top] ->
                Ok((List.drop_last(stk, 2), below, top))
            _ ->
                Err(StackUnderflow)

swap_top_two : Stack -> Result Stack EvalError
swap_top_two = |stk|
    if List.len(stk) < 2 then
        Err(StackUnderflow)
    else
        pair = List.take_last(stk, 2)
        when pair is
            [below, top] ->
                Ok(
                    List.concat(
                        List.drop_last(stk, 2),
                        [top, below],
                    ),
                )
            _ ->
                Err(StackUnderflow)

lowercase : Str -> Str
lowercase = |str|
    str
    |> Str.to_utf8
    |> List.map(|c|
        if c >= 'A' && c <= 'Z' then
            c + 32
        else
            c,
    )
    |> Str.from_utf8
    |> Result.with_default(str)
    