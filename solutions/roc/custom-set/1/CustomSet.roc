module [
    contains,
    difference,
    from_list,
    insert,
    intersection,
    is_disjoint_with,
    is_empty,
    is_eq,
    is_subset_of,
    to_list,
    union,
]

Element : U64

CustomSet : { elements : List Element }

contains : CustomSet, Element -> Bool
contains = |set, element|
    List.contains(set.elements, element)

difference : CustomSet, CustomSet -> CustomSet
difference = |set1, set2|
    { elements: List.keep_if(set1.elements, |element| !(List.contains(set2.elements, element))) }

from_list : List Element -> CustomSet
from_list = |list|
    { elements: List.walk(list, [], |unique_list, element|
        if List.contains(unique_list, element) then
            unique_list
        else
            List.append(unique_list, element)
    ) }

insert : CustomSet, Element -> CustomSet
insert = |set, element|
    if List.contains(set.elements, element) then
        set
    else
        { elements: List.append(set.elements, element) }

intersection : CustomSet, CustomSet -> CustomSet
intersection = |set1, set2|
    { elements: List.keep_if(set1.elements, |element| List.contains(set2.elements, element)) }

is_disjoint_with : CustomSet, CustomSet -> Bool
is_disjoint_with = |set1, set2|
    List.all(set1.elements, |element| !(List.contains(set2.elements, element)))

is_empty : CustomSet -> Bool
is_empty = |set|
    List.is_empty(set.elements)

is_eq : CustomSet, CustomSet -> Bool
is_eq = |set1, set2|
    (List.len(set1.elements) == List.len(set2.elements))
    && List.all(set1.elements, |element| List.contains(set2.elements, element))

is_subset_of : CustomSet, CustomSet -> Bool
is_subset_of = |set1, set2|
    List.all(set1.elements, |element| List.contains(set2.elements, element))

to_list : CustomSet -> List Element
to_list = |set|
    set.elements

union : CustomSet, CustomSet -> CustomSet
union = |set1, set2|
    { elements: List.walk(set2.elements, set1.elements, |result, element|
        if List.contains(result, element) then
            result
        else
            List.append(result, element)
    ) }