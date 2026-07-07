USING: arrays kernel math math.functions ranges sequences ;
IN: palindrome-products

:: is-palindrome ( num -- ? )
  num :> n!
  0 :> reversed!

  n 0 <=
  n 10 divisor?
  or
  [
    n 0 =
  ]
  [
    [ n reversed > ]
    [
      n 10 /mod
      reversed 10 * + reversed!
      n!
    ]
    while

    reversed n =
    reversed 10 /i  n =
    or
  ]
  if ;


:: smallest ( mn mx -- value factors )
  mn mx > [ "min must be <= max" throw ] when

  mx mx * 1 + :> value!
  V{ } clone :> factors!
  0 :> b!
  0 :> p!

  mn mx [a..b]
  [| a |
    a b!
    [
      a b * p!

      b mx <=
      p value <=
      and
    ]
    [
      p is-palindrome
      [
        p value <
        [
          p value!
          V{ } clone factors!
        ]
        when

        a b 2array factors push
      ]
      when

      b 1 + b!
    ]
    while
  ]
  each

  factors empty?
  [
    f value!
  ]
  when

  value factors >array  ;


:: largest ( mn mx -- value factors )
  mn mx > [ "min must be <= max" throw ] when

  -1 :> value!
  V{ } clone :> factors!
  0 :> b!
  0 :> p!

  mx mn [a..b]
  [| a |
    a b!
    [
      a b * p!

      b mn >=
      p value >=
      and
    ]
    [
      p is-palindrome
      [
        p value >
        [
          p value!
          V{ } clone factors!
        ]
        when

        b a 2array factors push
      ]
      when

      b 1 - b!
    ]
    while
  ]
  each

  factors empty?
  [
    f value!
  ]
  when

  value factors >array  ;