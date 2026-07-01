rec = (ps, iw, pl, il, ir) ->
  return {} if il > ir
  x = ps[pl]
  j = iw[x]
  assert (il <= j and j <= ir), "impossible tree"
  ls = j - il
  {
    v: x
    l: rec(ps, iw, pl + 1, il, j - 1)
    r: rec(ps, iw, pl + ls + 1, j + 1, ir)
  }

{
  tree: (preorder, inorder) ->
    do
      sort_copy = (list) ->
        copy = { table.unpack list }
        table.sort copy
        copy
      ps = sort_copy preorder
      is = sort_copy inorder
      assert #ps == #is, "traversals must have the same length"
      for i = 1, #ps
        assert ps[i] == is[i], "traversals must have the same elements"
      for i = 2, #ps
        assert ps[i - 1] != ps[i], "traversals must contain unique items"
    iwhere = { x, i for i, x in ipairs inorder }
    rec preorder, iwhere, 1, 1, #preorder
}