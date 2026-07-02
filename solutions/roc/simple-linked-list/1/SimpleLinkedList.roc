module [from_list, to_list, push, pop, reverse, len]

SimpleLinkedList : [Empty, Node { value : U64, next : SimpleLinkedList }]

from_list : List U64 -> SimpleLinkedList
from_list = \list ->
    List.walk list Empty \acc, value ->
        append_to_end acc value

to_list : SimpleLinkedList -> List U64
to_list = \linked_list ->
    to_list_helper linked_list []

to_list_helper : SimpleLinkedList, List U64 -> List U64
to_list_helper = \linked_list, acc ->
    when linked_list is
        Empty -> acc
        Node { value, next } -> to_list_helper next (List.append acc value)

push : SimpleLinkedList, U64 -> SimpleLinkedList
push = \linked_list, item ->
    append_to_end linked_list item

append_to_end : SimpleLinkedList, U64 -> SimpleLinkedList
append_to_end = \linked_list, value ->
    when linked_list is
        Empty -> Node { value, next: Empty }
        Node { value: head_value, next } ->
            Node { value: head_value, next: append_to_end next value }

pop : SimpleLinkedList -> Result { value : U64, linked_list : SimpleLinkedList } _
pop = \linked_list ->
    when linked_list is
        Empty -> Err {}
        Node { value, next: Empty } -> Ok { value, linked_list: Empty }
        Node { value, next } ->
            pop_result = pop next
            when pop_result is
                Ok { value: popped_value, linked_list: remaining_list } ->
                    Ok { value: popped_value, linked_list: Node { value, next: remaining_list } }
                Err {} -> Err {} # This should never happen

reverse : SimpleLinkedList -> SimpleLinkedList
reverse = \linked_list ->
    reverse_helper linked_list Empty

reverse_helper : SimpleLinkedList, SimpleLinkedList -> SimpleLinkedList
reverse_helper = \current, acc ->
    when current is
        Empty -> acc
        Node { value, next } -> reverse_helper next (Node { value, next: acc })

len : SimpleLinkedList -> U64
len = \linked_list ->
    len_helper linked_list 0

len_helper : SimpleLinkedList, U64 -> U64
len_helper = \linked_list, count ->
    when linked_list is
        Empty -> count
        Node { next } -> len_helper next (count + 1)