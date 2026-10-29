Camicia :: {}.{
    Card := [Number(U8), Jack, Queen, King, Ace].{
        from_quote : Str -> Try(Card, [BadQuotedBytes(Str)])
        from_quote = |card_str| {
            when card_str {
                "J" => Ok(Jack)
                "Q" => Ok(Queen)
                "K" => Ok(King)
                "A" => Ok(Ace)
                "2" => Ok(Number(2))
                "3" => Ok(Number(3))
                "4" => Ok(Number(4))
                "5" => Ok(Number(5))
                "6" => Ok(Number(6))
                "7" => Ok(Number(7))
                "8" => Ok(Number(8))
                "9" => Ok(Number(9))
                "10" => Ok(Number(10))
                _ => Err(BadQuotedBytes(card_str))
            }
        }
    }

    GameOutcome : {
        status : [Finished, Loop],
        cards : U64,
        tricks : U64,
    }

    simulate_game : { player_a : List(Card), player_b : List(Card) } -> GameOutcome
    simulate_game = |{ player_a, player_b }| {
        crash "Simulation implementation required"
    }
}
