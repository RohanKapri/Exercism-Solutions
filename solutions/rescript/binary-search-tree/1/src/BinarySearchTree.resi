type rec tree =
  | EmptyTree
  | TreeNode({value: int, left: tree, right: tree})

let binarySearchTree: array<int> => tree
let sortedData: tree => array<int>
