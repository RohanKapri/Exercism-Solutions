type rec tree =
  | EmptyTree
  | TreeNode({value: int, left: tree, right: tree})
// note the syntactic sugar for destructuring a record, like JavaScript
let rec insert = (tree, item) =>
  switch tree {
  | EmptyTree => TreeNode({value: item, left: EmptyTree, right: EmptyTree})
  | TreeNode({value, left, right}) if item <= value => TreeNode({value, left: insert(left, item), right})
  | TreeNode({value, left, right}) => TreeNode({value, left, right: insert(right, item)})
  }
let binarySearchTree = values => Array.reduce(values, EmptyTree, (t, val) => insert(t, val))
let rec sortedData = aTree =>
  switch aTree {
  | EmptyTree => []
  | TreeNode(node) =>
      sortedData(node.left)
      ->Array.concat([node.value])
      ->Array.concat(sortedData(node.right))
  }
