{
  commands: (value) ->
    actions = {}

    table.insert actions, 'wink' if math.floor(value / 1) % 2 == 1
    table.insert actions, 'double blink' if math.floor(value / 2) % 2 == 1
    table.insert actions, 'close your eyes' if math.floor(value / 4) % 2 == 1
    table.insert actions, 'jump' if math.floor(value / 8) % 2 == 1

    if math.floor(value / 16) % 2 == 1
      reversed = {}
      for i = #actions, 1, -1
        table.insert reversed, actions[i]
      actions = reversed

    actions
}