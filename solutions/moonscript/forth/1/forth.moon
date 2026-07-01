class Forth
  new: =>
    @st = {}
    @op =
      "+": @use2 (a, b) -> @push a + b
      "-": @use2 (a, b) -> @push a - b
      "*": @use2 (a, b) -> @push a * b
      "/": @use2 (a, b) ->
        assert b != 0, 'divide by zero'
        @push a // b

      drop: -> @pop1!
      dup: @use1 (a) ->
        @push a
        @push a
      swap: @use2 (a, b) ->
        @push b
        @push a
      over: @use2 (a, b) ->
        @push a
        @push b
        @push a

  push: (x) => table.insert @st, x

  use1: (f1) => -> f1 @pop1!
  use2: (f2) => -> f2 @pop2!

  pop1: =>
    with x = table.remove @st
      assert x, 'empty stack'
  pop2: =>
    top = @pop1!
    x = table.remove @st
    assert x, 'only one value on the stack'
    x, top

  get_fn: (w) =>
    if n = tonumber w
      -> @push n
    else
      @get_op w
  get_op: (w) =>
    with op = @op[w]
      assert op, 'undefined operation'

  defn: (inst) =>
    w = inst[2]
    assert (not tonumber w), 'illegal operation'
    seq = [ @get_fn inst[i] for i = 3, (#inst - 1) ]
    @op[w] = -> fn! for fn in *seq

  stack: => @st

  evaluate: (script) =>
    for line in *script
      inst = [ w\lower! for w in line\gmatch "[^ ]+" ]
      if inst[1] == ":"
        @defn inst
      else
        @get_fn(w)! for w in *inst