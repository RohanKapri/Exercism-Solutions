module [keep, discard]

keep : List a, (a -> Bool) -> List a
keep = |list, predicate|
    List.walk_backwards(list, [], |acc, elem|
        if predicate(elem) then
            List.prepend(acc, elem)
        else
            acc
    )

discard : List a, (a -> Bool) -> List a
discard = |list, predicate|
    keep(list, |elem| !(predicate(elem)))
      