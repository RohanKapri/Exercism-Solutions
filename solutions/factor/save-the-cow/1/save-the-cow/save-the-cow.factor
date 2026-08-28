USING: kernel locals math sequences strings ;
IN: save-the-cow

:: guess ( word guesses -- state masked remaining )
  "Ongoing" :> state!
  word length  95  <string> :> masked!
  9 :> remaining!
  f :> update!

  guesses
  [| g |
    state "Lose" = [ "cannot guess after the game is lost" throw ] when
    state "Win" = [ "cannot guess after the game is won" throw ] when

    word masked
    [| w m |
      w g =
      [
        g
      ]
      [
        m
      ]
      if
    ]
    2map :> update

    update masked =
    [
      remaining 0 =
      [
        "Lose" state!
      ]
      [
        remaining 1 - remaining!
      ]
      if
    ]
    [
      update masked!
      masked word = [ "Win" state! ] when
    ]
    if
  ]
  each

  state masked remaining ;