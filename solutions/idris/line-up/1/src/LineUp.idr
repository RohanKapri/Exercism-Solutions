module LineUp

ordinal : Int -> String
ordinal n =
  let lastTwo = mod n 100
      lastOne = mod n 10
      suffix =
        if lastTwo >= 11 && lastTwo <= 13 then
          "th"
        else
          case lastOne of
            1 => "st"
            2 => "nd"
            3 => "rd"
            _ => "th"
  in
    show n ++ suffix

export
format : String -> Int -> String
format name number =
  name ++ ", you are the " ++ ordinal number
       ++ " customer we serve today. Thank you!"