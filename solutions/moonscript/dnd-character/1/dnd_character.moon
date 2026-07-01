roll = () ->
    total = 0
    smallest = 6
    for i = 1, 4
      score = math.random(6)
      total += score
      if score < smallest
        smallest = score
    total - smallest


{
  modifier: (score) ->
    (score - 10) // 2

  ability: ->
    roll()

  character: ->
    constitution = roll()

    {
      strength: roll()
      dexterity: roll()
      constitution: constitution
      intelligence: roll()
      wisdom: roll()
      charisma: roll()
      hitpoints: 10 + (constitution - 10) // 2
      dexterity: roll()
    }
}