module [recite]

animals = [
    ("fly", ""),
    ("spider", "It wriggled and jiggled and tickled inside her."),
    ("bird", "How absurd to swallow a bird!"),
    ("cat", "Imagine that, to swallow a cat!"),
    ("dog", "What a hog, to swallow a dog!"),
    ("goat", "Just opened her throat and swallowed a goat!"),
    ("cow", "I don't know how she swallowed a cow!"),
]

recite : U64, U64 -> Str
recite = |start, end|
    List.range({ start: At(start), end: At(end) })
    |> List.map(verse)
    |> Str.join_with("\n\n")

verse : U64 -> Str
verse = |n|
    if n == 8 then
        "I know an old lady who swallowed a horse.\nShe's dead, of course!"
    else
        (animal, comment) = List.get(animals, n - 1) |> Result.with_default(("", ""))
        opening = "I know an old lady who swallowed a $(animal)."
        comment_line = if comment == "" then "" else "\n$(comment)"
        chain = if n == 1 then "" else "\n$(build_chain(n))"
        ending = "\nI don't know why she swallowed the fly. Perhaps she'll die."
        "$(opening)$(comment_line)$(chain)$(ending)"

build_chain : U64 -> Str
build_chain = |n|
    List.range({ start: At(1), end: Before(n) })
    |> List.reverse
    |> List.map(|i|
        (curr, _) = List.get(animals, i) |> Result.with_default(("", ""))
        (prev, _) = List.get(animals, i - 1) |> Result.with_default(("", ""))
        suffix = if prev == "spider" then " that wriggled and jiggled and tickled inside her" else ""
        "She swallowed the $(curr) to catch the $(prev)$(suffix).")
    |> Str.join_with("\n")
                                                              