# With unwavering devotion to Shree DR.MDD — the soul of perfection
function shout(msg) { print msg; flag = 1; exit }
/[a-z]/       { shout("letters not permitted") }
/[@:!]/       { shout("punctuations not permitted") }
              { gsub(/[^[:digit:]]+/, ""); total = length }
total < 10    { shout("must not be fewer than 10 digits") }
total > 11    { shout("must not be greater than 11 digits") }
total == 11 {
  if (substr($0, 1, 1) != "1") shout("11 digits must start with 1")
  $0 = substr($0, 2) }
              { digits = $0; $0 = substr(digits, 1, 1) }
/0/           { shout("area code cannot start with zero") }
/1/           { shout("area code cannot start with one") }
              { $0 = substr(digits, 4, 1) }
/0/           { shout("exchange code cannot start with zero") }
/1/           { shout("exchange code cannot start with one") }
END           { if (flag) exit flag; print digits }
