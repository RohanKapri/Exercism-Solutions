module [from_list, to_list]

BinaryTree : [Nil, Node { value : U64, left : BinaryTree, right : BinaryTree }]

## Builds a binary search tree from a list of values by inserting each value in order.
from_list : List U64 -> BinaryTree
from_list = |data|
    List.walk(data, Nil, |tree, value| insert(tree, value))

## Inserts a value into a binary search tree.
## Values less than or equal to the current node go left, greater values go right.
insert : BinaryTree, U64 -> BinaryTree
insert = |tree, value|
    when tree is
        Nil -> Node({ value: value, left: Nil, right: Nil })
        Node(node) ->
            if value <= node.value then
                Node({ node & left: insert(node.left, value) })
            else
                Node({ node & right: insert(node.right, value) })

## Converts a binary search tree to a sorted list using in-order traversal.
to_list : BinaryTree -> List U64
to_list = |tree|
    when tree is
        Nil -> []
        Node(node) ->
            left_values = to_list(node.left)
            right_values = to_list(node.right)
            List.concat(left_values, List.concat([node.value], right_values))
                                                                                 