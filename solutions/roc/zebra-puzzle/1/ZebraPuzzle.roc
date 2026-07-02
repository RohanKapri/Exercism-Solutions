module [owns_zebra, drinks_water]

Person : [Englishman, Spaniard, Ukrainian, Norwegian, Japanese]
Color : [Red, Green, Ivory, Yellow, Blue]
Pet : [Dog, Snail, Fox, Horse, Zebra]
Drink : [Coffee, Tea, Milk, OrangeJuice, Water]
Hobby : [Dancing, Painting, Reading, Football, Chess]

House : {
    position : U8,
    person : Person,
    color : Color,
    pet : Pet,
    drink : Drink,
    hobby : Hobby,
}

all_persons : List Person
all_persons = [Englishman, Spaniard, Ukrainian, Norwegian, Japanese]

all_colors : List Color
all_colors = [Red, Green, Ivory, Yellow, Blue]

all_pets : List Pet
all_pets = [Dog, Snail, Fox, Horse, Zebra]

all_drinks : List Drink
all_drinks = [Coffee, Tea, Milk, OrangeJuice, Water]

all_hobbies : List Hobby
all_hobbies = [Dancing, Painting, Reading, Football, Chess]

next_to : U8, U8 -> Bool
next_to = |a, b| (if a > b then a - b else b - a) == 1

find_house : List House, (House -> Bool) -> Result House _
find_house = |houses, pred|
    List.find_first(houses, pred)

# Check two-house positional constraints on a partial assignment.
# Returns Bool.false only when a violation is already confirmed.
partial_ok : List House -> Bool
partial_ok = |houses|
    # Clue 6: green is immediately to the right of ivory
    c6 =
        r_ivory = find_house(houses, |h| h.color == Ivory)
        r_green = find_house(houses, |h| h.color == Green)
        when (r_ivory, r_green) is
            (Ok(iv), Ok(gr)) -> gr.position == iv.position + 1
            (Ok(iv), Err(_)) -> iv.position < 5  # ivory at pos 5 leaves no room for green
            (Err(_), Ok(gr)) -> gr.position > 1  # green at pos 1 leaves no room for ivory
            _ -> Bool.true
    # Clue 15: Norwegian (always pos 1) next to blue => blue must be pos 2
    c15 =
        r_blue = find_house(houses, |h| h.color == Blue)
        when r_blue is
            Ok(bl) -> bl.position == 2
            Err(_) -> Bool.true
    # Clue 11: reader lives next to the fox owner
    c11 =
        r_reader = find_house(houses, |h| h.hobby == Reading)
        r_fox = find_house(houses, |h| h.pet == Fox)
        when (r_reader, r_fox) is
            (Ok(rd), Ok(fx)) -> next_to(rd.position, fx.position)
            _ -> Bool.true
    # Clue 12: painter lives next to the horse owner
    c12 =
        r_painter = find_house(houses, |h| h.hobby == Painting)
        r_horse = find_house(houses, |h| h.pet == Horse)
        when (r_painter, r_horse) is
            (Ok(pt), Ok(hr)) -> next_to(pt.position, hr.position)
            _ -> Bool.true
    c6 && c15 && c11 && c12

# Core backtracking search.
# Builds the solution house by house from position 1 to 5.
backtrack : List House, U8 -> Result (List House) _
backtrack = |assigned, pos|
    if pos > 5 then
        Ok(assigned)
    else
        avail_persons = List.keep_if(all_persons, |p| !(List.any(assigned, |h| h.person == p)))
        avail_colors = List.keep_if(all_colors, |c| !(List.any(assigned, |h| h.color == c)))
        avail_pets = List.keep_if(all_pets, |p| !(List.any(assigned, |h| h.pet == p)))
        avail_drinks = List.keep_if(all_drinks, |d| !(List.any(assigned, |h| h.drink == d)))
        avail_hobbies = List.keep_if(all_hobbies, |hb| !(List.any(assigned, |h| h.hobby == hb)))

        List.walk_until(avail_persons, Err(NotFound), |_, person|
            # Clue 10: Norwegian in house 1 (bidirectional)
            if person == Norwegian && pos != 1 then Continue(Err(NotFound))
            else if person != Norwegian && pos == 1 then Continue(Err(NotFound))
            else
                r_colors = List.walk_until(avail_colors, Err(NotFound), |_, color|
                    # Clue 2: Englishman <-> red house
                    if person == Englishman && color != Red then Continue(Err(NotFound))
                    else if color == Red && person != Englishman then Continue(Err(NotFound))
                    else
                        r_drinks = List.walk_until(avail_drinks, Err(NotFound), |_, drink|
                            # Clue 9: middle house drinks milk
                            if pos == 3 && drink != Milk then Continue(Err(NotFound))
                            else if pos != 3 && drink == Milk then Continue(Err(NotFound))
                            # Clue 4: green house <-> coffee
                            else if color == Green && drink != Coffee then Continue(Err(NotFound))
                            else if drink == Coffee && color != Green then Continue(Err(NotFound))
                            # Clue 5: Ukrainian <-> tea
                            else if person == Ukrainian && drink != Tea then Continue(Err(NotFound))
                            else if drink == Tea && person != Ukrainian then Continue(Err(NotFound))
                            else
                                r_pets = List.walk_until(avail_pets, Err(NotFound), |_, pet|
                                    # Clue 3: Spaniard <-> dog
                                    if person == Spaniard && pet != Dog then Continue(Err(NotFound))
                                    else if pet == Dog && person != Spaniard then Continue(Err(NotFound))
                                    else
                                        r_hobbies = List.walk_until(avail_hobbies, Err(NotFound), |_, hobby|
                                            # Clue 8: yellow house <-> painter
                                            if color == Yellow && hobby != Painting then Continue(Err(NotFound))
                                            else if hobby == Painting && color != Yellow then Continue(Err(NotFound))
                                            # Clue 7: snail owner <-> dancer
                                            else if pet == Snail && hobby != Dancing then Continue(Err(NotFound))
                                            else if hobby == Dancing && pet != Snail then Continue(Err(NotFound))
                                            # Clue 13: football player <-> orange juice
                                            else if hobby == Football && drink != OrangeJuice then Continue(Err(NotFound))
                                            else if drink == OrangeJuice && hobby != Football then Continue(Err(NotFound))
                                            # Clue 14: Japanese <-> chess
                                            else if person == Japanese && hobby != Chess then Continue(Err(NotFound))
                                            else if hobby == Chess && person != Japanese then Continue(Err(NotFound))
                                            else
                                                new_house = { position: pos, person, color, pet, drink, hobby }
                                                new_assigned = List.append(assigned, new_house)
                                                if !(partial_ok(new_assigned)) then Continue(Err(NotFound))
                                                else
                                                    when backtrack(new_assigned, pos + 1) is
                                                        Ok(result) -> Break(Ok(result))
                                                        Err(_) -> Continue(Err(NotFound)))
                                        when r_hobbies is
                                            Ok(h) -> Break(Ok(h))
                                            Err(_) -> Continue(Err(NotFound)))
                                when r_pets is
                                    Ok(h) -> Break(Ok(h))
                                    Err(_) -> Continue(Err(NotFound)))
                        when r_drinks is
                            Ok(h) -> Break(Ok(h))
                            Err(_) -> Continue(Err(NotFound)))
                when r_colors is
                    Ok(h) -> Break(Ok(h))
                    Err(_) -> Continue(Err(NotFound)))

solution : Result (List House) _
solution = backtrack([], 1)

owns_zebra : Result Person _
owns_zebra =
    solution
    |> Result.try(|houses| find_house(houses, |h| h.pet == Zebra))
    |> Result.map_ok(|h| h.person)

drinks_water : Result Person _
drinks_water =
    solution
    |> Result.try(|houses| find_house(houses, |h| h.drink == Water))
    |> Result.map_ok(|h| h.person)
    