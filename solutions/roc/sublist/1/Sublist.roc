module [sublist]

sublist : List a, List a -> [Equal, Sublist, Superlist, Unequal] where a implements Eq
sublist = \list1, list2 ->
    if List.is_empty list1 && List.is_empty list2 then
        Equal
    else if List.is_empty list1 then
        Sublist
    else if List.is_empty list2 then
        Superlist
    else if list1 == list2 then
        Equal
    else if isSublist list1 list2 then
        Sublist
    else if isSublist list2 list1 then
        Superlist
    else
        Unequal

isSublist : List a, List a -> Bool where a implements Eq
isSublist = \subList, mainList ->
    if List.is_empty subList then
        Bool.true
    else if List.len subList > List.len mainList then
        Bool.false
    else
        startsWith = List.starts_with mainList subList
        if startsWith then
            Bool.true
        else
            isSublist subList (List.drop_first mainList 1)
      