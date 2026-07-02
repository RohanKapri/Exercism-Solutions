module [get, post, User, Database]

import json.Json

User : {
    name : Str,
    owes : Dict Str F64,
    owed_by : Dict Str F64,
    balance : F64,
}

Database : { users : List User }

get : Database, { url : Str, payload ?? Str } -> Result Str _
get = |database, { url, payload ?? "" }|
    if url != "/users" then
        Err(BadRoute)
    else if Str.is_empty(payload) then
        Ok(encode_users_json(sort_by_name(database.users)))
    else
        when Decode.from_bytes(Str.to_utf8(payload), Json.utf8) is
            Ok(q) ->
                name_set = Set.from_list(q.users)
                chosen =
                    List.keep_if(database.users, |u| Set.contains(name_set, u.name))
                Ok(encode_users_json(sort_by_name(chosen)))

            Err(_) ->
                Err(BadJson)

post : Database, { url : Str, payload ?? Str } -> Result Str _
post = |database, { url, payload ?? "" }|
    when url is
        "/add" ->
            when Decode.from_bytes(Str.to_utf8(payload), Json.utf8) is
                Ok(b) ->
                    new_name = b.user
                    when find_user(database.users, new_name) is
                        Ok(_) ->
                            Err(DuplicateUser)

                        Err(NotFound) ->
                            new_u =
                                {
                                    name: new_name,
                                    owes: Dict.empty({}),
                                    owed_by: Dict.empty({}),
                                    balance: 0,
                                }
                            Ok(user_to_json_str(new_u))

                Err(_) ->
                    Err(BadJson)

        "/iou" ->
            when Decode.from_bytes(Str.to_utf8(payload), Json.utf8) is
                Ok(b) ->
                    when (find_user(database.users, b.lender), find_user(database.users, b.borrower)) is
                        (Ok(lender), Ok(borrower)) ->
                            (lu, bu) = apply_iou(lender, borrower, b.amount)
                            Ok(encode_users_json(sort_by_name([lu, bu])))

                        _ ->
                            Err(MissingUser)

                Err(_) ->
                    Err(BadJson)

        _ ->
            Err(BadRoute)

encode_users_json : List User -> Str
encode_users_json = |users|
    inner =
        List.walk(
            users,
            "",
            |acc, u|
                piece = user_to_json_str(u)
                if Str.is_empty(acc) then
                    piece
                else
                    Str.concat(Str.concat(acc, ","), piece),
        )
    "{\"users\":[$(inner)]}"

user_to_json_str : User -> Str
user_to_json_str = |u|
    "{\"balance\":$(f64_json(u.balance)),\"name\":\"$(u.name)\",\"owed_by\":$(dict_f64_json(u.owed_by)),\"owes\":$(dict_f64_json(u.owes))}"

f64_json : F64 -> Str
f64_json = |n|
    Num.to_str(n)

dict_f64_json : Dict Str F64 -> Str
dict_f64_json = |d|
    if Dict.is_empty(d) then
        "{}"
    else
        pairs =
            Dict.to_list(d)
            |> List.sort_with(
                |(k1, _), (k2, _)|
                    cmp_utf8(Str.to_utf8(k1), Str.to_utf8(k2)),
            )
        inner =
            List.walk(
                pairs,
                "",
                |acc, (k, v)|
                    piece = "\"$(k)\":$(f64_json(v))"
                    if Str.is_empty(acc) then
                        piece
                    else
                        Str.concat(Str.concat(acc, ","), piece),
            )
        Str.concat(Str.concat("{", inner), "}")

sort_by_name : List User -> List User
sort_by_name = |users|
    List.sort_with(
        users,
        |a, b|
            cmp_utf8(Str.to_utf8(a.name), Str.to_utf8(b.name)),
    )

cmp_utf8 : List U8, List U8 -> [LT, EQ, GT]
cmp_utf8 = |l1, l2|
    when (l1, l2) is
        ([], []) -> EQ
        ([], _) -> LT
        (_, []) -> GT
        ([b1, .. as r1], [b2, .. as r2]) ->
            if b1 < b2 then
                LT
            else if b1 > b2 then
                GT
            else
                cmp_utf8(r1, r2)

find_user : List User, Str -> Result User [NotFound]
find_user = |users, name|
    find_user_help(users, name)

find_user_help : List User, Str -> Result User [NotFound]
find_user_help = |users, name|
    when users is
        [] ->
            Err(NotFound)

        [u, .. as rest] ->
            if u.name == name then
                Ok(u)
            else
                find_user_help(rest, name)

sum_dict : Dict Str F64 -> F64
sum_dict = |d|
    Dict.walk(d, 0, |acc, _, v| acc + v)

with_balance : User -> User
with_balance = |u|
    {
        name: u.name,
        owes: u.owes,
        owed_by: u.owed_by,
        balance: sum_dict(u.owed_by) - sum_dict(u.owes),
    }

strip_peer : User, Str -> User
strip_peer = |u, peer|
    {
        name: u.name,
        owes: Dict.remove(u.owes, peer),
        owed_by: Dict.remove(u.owed_by, peer),
        balance: u.balance,
    }

apply_iou : User, User, F64 -> (User, User)
apply_iou = |lender, borrower, amount|
    l_name = lender.name
    b_name = borrower.name
    lender_owes_b =
        Dict.get(lender.owes, b_name) |> Result.with_default(0)
    b_owes_l =
        Dict.get(lender.owed_by, b_name) |> Result.with_default(0)
    net = b_owes_l + amount - lender_owes_b
    lender1 = strip_peer(lender, b_name)
    borrower1 = strip_peer(borrower, l_name)
    if net > 0 then
        l2 =
            {
                name: lender1.name,
                owes: lender1.owes,
                owed_by: Dict.insert(lender1.owed_by, b_name, net),
                balance: lender1.balance,
            }
        b2 =
            {
                name: borrower1.name,
                owes: Dict.insert(borrower1.owes, l_name, net),
                owed_by: borrower1.owed_by,
                balance: borrower1.balance,
            }
        (with_balance(l2), with_balance(b2))
    else if net < 0 then
        owe = -net
        l2 =
            {
                name: lender1.name,
                owes: Dict.insert(lender1.owes, b_name, owe),
                owed_by: lender1.owed_by,
                balance: lender1.balance,
            }
        b2 =
            {
                name: borrower1.name,
                owes: borrower1.owes,
                owed_by: Dict.insert(borrower1.owed_by, l_name, owe),
                balance: borrower1.balance,
            }
        (with_balance(l2), with_balance(b2))
    else
        (with_balance(lender1), with_balance(borrower1))