insert = (tree, value) ->
  if tree
    if value <= tree.data
      tree.left = insert tree.left, value
    else
      tree.right = insert tree.right, value
    tree
  else
    { data: value }

inorder = (tree, res) ->
  if tree
    inorder(tree.left, res)
    table.insert(res, tree.data)
    inorder(tree.right, res)

class BinarySearchTree
  new: (items) =>
    @root = nil
    for x in *items
      @root = insert @root, x
  data: => @root
  sorted: =>
    with res = {}
      inorder @root, res