module [two_fer]

two_fer : [Name Str, Anonymous] -> Str
two_fer = |name|
    when name is
        Name(n) -> Str.concat "One for " (Str.concat n ", one for me.")
        Anonymous -> "One for you, one for me."
           