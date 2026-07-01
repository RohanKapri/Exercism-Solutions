module [allergic_to, set]

Allergen : [Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats]

allergenMask : Allergen -> U64
allergenMask = |allergen|
    when allergen is
        Eggs -> 1
        Peanuts -> 2
        Shellfish -> 4
        Strawberries -> 8
        Tomatoes -> 16
        Chocolate -> 32
        Pollen -> 64
        Cats -> 128

allergic_to : Allergen, U64 -> Bool
allergic_to = |allergen, score|
    Num.bitwise_and score (allergenMask allergen) != 0

allAllergens : List Allergen
allAllergens =
    [
        Eggs,
        Peanuts,
        Shellfish,
        Strawberries,
        Tomatoes,
        Chocolate,
        Pollen,
        Cats,
    ]

set : U64 -> Set Allergen
set = |score|
    allAllergens
        |> List.keep_if (\allergen -> allergic_to(allergen, score))
        |> Set.from_list
    