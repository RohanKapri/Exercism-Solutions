module [append, concat, filter, length, map, foldl, foldr, reverse]

## Walk list1 backwards, prepending each element onto list2.
## Result: list1 ++ list2, built in a single left-fold with no extra allocation.
append : List a, List a -> List a
append = \list1, list2 ->
    List.walk_backwards list1 list2 \acc, x -> List.prepend acc x

## Fold each sub-list into the accumulator with append.
concat : List (List a) -> List a
concat = \lists ->
    foldl lists [] append

## Walk backwards; only prepend elements that pass the predicate.
filter : List a, (a -> Bool) -> List a
filter = \list, function ->
    List.walk_backwards list [] \acc, x ->
        if function x then List.prepend acc x else acc

## Single left-walk counting elements.
length : List a -> U64
length = \list ->
    List.walk list 0 \acc, _ -> acc + 1

## Walk backwards; prepend transformed elements to keep original order.
map : List a, (a -> b) -> List b
map = \list, function ->
    List.walk_backwards list [] \acc, x -> List.prepend acc (function x)

## Left fold delegated to List.walk (matches fold-left semantics exactly).
foldl : List a, b, (b, a -> b) -> b
foldl = \list, initial, function ->
    List.walk list initial function

## Right fold: walk backwards so the rightmost element is visited first.
foldr : List a, b, (b, a -> b) -> b
foldr = \list, initial, function ->
    List.walk_backwards list initial function

## Prepend each element onto the accumulator while walking left → right.
reverse : List a -> List a
reverse = \list ->
    List.walk list [] \acc, x -> List.prepend acc x
     