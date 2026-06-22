class Satellite
  @treeFromTraversals: (preorder, inorder) ->

    # Length check
    unless preorder.length is inorder.length
      throw new Error 'traversals must have the same length'

    # Unique items check
    preSet = new Set preorder
    inSet = new Set inorder

    unless preSet.size is preorder.length and inSet.size is inorder.length
      throw new Error 'traversals must contain unique items'

    # Same elements check
    for x in preorder
      unless inSet.has x
        throw new Error 'traversals must have the same elements'

    for x in inorder
      unless preSet.has x
        throw new Error 'traversals must have the same elements'

    build = (pre, ino) ->
      return {} if pre.length is 0

      root = pre[0]
      idx = ino.indexOf root

      leftIn = ino.slice 0, idx
      rightIn = ino.slice idx + 1

      leftPre = pre.slice 1, 1 + leftIn.length
      rightPre = pre.slice 1 + leftIn.length

      value: root
      left: build leftPre, leftIn
      right: build rightPre, rightIn

    build preorder, inorder

module.exports = Satellite