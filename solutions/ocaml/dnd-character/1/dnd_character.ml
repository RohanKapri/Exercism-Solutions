type character = {
  charisma : int;
  constitution : int;
  dexterity : int;
  hitpoints : int;
  intelligence : int;
  strength : int;
  wisdom : int;
}

let ability () =
  let values = List.init 4 Fun.id |> List.map (fun _ -> Random.int 6 + 1) in
  let sum = List.fold_left ( + ) 0 values in
  let min = List.fold_left Int.min Int.max_int values in
  sum - min

let modifier ~score =
  int_of_float @@ Float.floor @@ (float_of_int (score - 10) /. 2.0)

let generate_character () =
  let strength = ability () in
  let dexterity = ability () in
  let constitution = ability () in
  let intelligence = ability () in
  let wisdom = ability () in
  let charisma = ability () in
  let hitpoints = 10 + modifier ~score:constitution in
  {
    strength;
    dexterity;
    constitution;
    intelligence;
    wisdom;
    charisma;
    hitpoints;
  }