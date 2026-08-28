struct Tree
    root::String
    left::Union{Tree, Nothing}
    right::Union{Tree, Nothing}
end

function tree_from_traversals(preorder, inorder)
    !issetequal(preorder, inorder) &&
        throw(ArgumentError("inorder"))
    length(preorder) != length(unique(preorder)) &&
        throw(ArgumentError("preorder"))
    _gettree(preorder, inorder)
end

function _gettree(preorder, inorder)
    isempty(preorder) && return
    t = preorder[1]
    i = findfirst(==(t), inorder)
    l = _gettree(preorder[2:i], inorder[1:i-1])
    r = _gettree(preorder[i+1:end], inorder[i+1:end])
    Tree(t, l, r)
end