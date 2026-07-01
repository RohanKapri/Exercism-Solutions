class Bucket
  new: (v = 0, c = 0) =>
    @volume = v
    @capacity = c
  copy: => Bucket @volume, @capacity
  hash: => "#{@volume}, #{@capacity}"

class State
  new: (one = Bucket!, two = Bucket!, initial = "", moves = 0) =>
    @one = one
    @two = two
    @initial = initial
    @moves = moves
    
  copy: => State @one\copy!, @two\copy!, @initial, @moves + 1
  hash: => "#{@one\hash!}, #{@two\hash!}"

  pour_1_2: =>
    poured = math.min @one.volume, @two.capacity - @two.volume
    with @copy!
      .one.volume -= poured
      .two.volume += poured

  pour_2_1: =>
    poured = math.min @two.volume, @one.capacity - @one.volume
    with @copy!
      .one.volume += poured
      .two.volume -= poured

  fill_1: => 
    with @copy!
      .one.volume = .one.capacity
      
  fill_2: => 
    with @copy!
      .two.volume = .two.capacity
      
  empty_1: => 
    with @copy!
      .one.volume = 0
      
  empty_2: => 
    with @copy!
      .two.volume = 0

  is_valid: =>
    return @one.volume != 0 or @two.volume != @two.capacity if @initial == "one"
    @two.volume != 0 or @one.volume != @one.capacity

state_factory = (params) ->
  is_one = params.startBucket == "one"
  with State!
    .one = Bucket (if is_one then params.bucketOne else 0), params.bucketOne
    .two = Bucket (if is_one then 0 else params.bucketTwo), params.bucketTwo
    .initial = params.startBucket
    .moves = 1

class Solution
  new: (moves, goal, other) =>
    @moves = moves
    @goalBucket = goal
    @otherBucket = other
    
{
  measure: (params) ->
    initial = state_factory params
    queue = { initial }
    visited = { [initial\hash!]: true }
    
    while #queue > 0
      state = table.remove queue, 1
      
      return Solution state.moves, "one", state.two.volume if state.one.volume == params.goal
      return Solution state.moves, "two", state.one.volume if state.two.volume == params.goal

      new_states = { 
        state\pour_1_2!
        state\pour_2_1!
        state\fill_1!
        state\fill_2!
        state\empty_1!
        state\empty_2!
      }

      for new_state in *new_states
        hash = new_state\hash!
        if new_state\is_valid! and not visited[hash]
          table.insert queue, new_state
          visited[hash] = true

    error "Unreachable state"
}