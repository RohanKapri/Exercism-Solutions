module SaveTheCow

open System

type Progress =
    | Busy of int
    | Win
    | Lose

type State = {
    progress : Progress
    maskedWord : string
}

type Game =
    { secret : string
      mutable guessed : Set<char>
      mutable failures : int
      event : Event<State> }

let private makeMaskedWord secret guessed =
    secret
    |> Seq.map (fun c -> if Set.contains c guessed then c else '_')
    |> Array.ofSeq
    |> String

let private currentState game =
    let masked = makeMaskedWord game.secret game.guessed
    let progress =
        if masked = game.secret then
            Win
        elif game.failures <= 0 then
            Lose
        else
            Busy game.failures

    {
        progress = progress
        maskedWord = masked
    }

let createGame secret =
    {
        secret = secret
        guessed = Set.empty
        failures = 9
        event = Event<State>()
    }

let statesObservable game =
    game.event.Publish

let startGame game =
    game.event.Trigger(currentState game)

let makeGuess letter game =
    match currentState game with
    | { progress = Win }
    | { progress = Lose } -> ()
    | _ ->
        if Set.contains letter game.guessed then
            game.failures <- game.failures - 1
        else
            game.guessed <- Set.add letter game.guessed
            if not (game.secret.Contains(string letter)) then
                game.failures <- game.failures - 1

        game.event.Trigger(currentState game)