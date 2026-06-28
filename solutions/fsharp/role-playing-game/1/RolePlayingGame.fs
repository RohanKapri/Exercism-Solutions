module RolePlayingGame

type Player = { 
    Name: string option
    Level: int
    Health: int
    Mana: int option
}

let introduce (player: Player): string = 
    Option.defaultValue "Mighty Magician" player.Name

let revive (player: Player): Player option = 
    match player with
    | {Health = 0; Level = level} -> Some {player with Health = 100; Mana = if level >= 10 then Some 100 else None }
    | _ -> None

let castSpell (manaCost: int) (player: Player): Player * int =
    match player with
    | {Mana = Some mana} when mana < manaCost -> player, 0
    | {Mana = Some mana} -> {player with Mana = Some (mana - manaCost)}, manaCost * 2
    | {Mana = None; Health = health} -> {player with Health = max (health - manaCost) 0}, 0