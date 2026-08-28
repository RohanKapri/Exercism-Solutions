module Hangman exposing (Msg(..), init, update, view)

import Html exposing (Html, dd, div, dl, dt, p, text)
import Set exposing (Set)



-- MODEL


type GameStatus
    = Ongoing
    | Win
    | Lose


type alias PlayingModel =
    { word : String
    , uniqueLetters : Set Char
    , revealed : Set Char
    , remainingFailures : Int
    , status : GameStatus
    }


type Model
    = Playing PlayingModel
    | Errored String


charSetFromString : String -> Set Char
charSetFromString =
    String.foldl Set.insert Set.empty


init : String -> Model
init word =
    Playing
        { word = word
        , uniqueLetters = charSetFromString word
        , revealed = Set.empty
        , remainingFailures = 9
        , status = Ongoing
        }



-- UPDATE


type Msg
    = Guess Char


isNewSuccessfulGuess : Char -> PlayingModel -> Bool
isNewSuccessfulGuess letter playing =
    Set.member letter playing.uniqueLetters
        && not (Set.member letter playing.revealed)


wonAfterReveal : Set Char -> PlayingModel -> Bool
wonAfterReveal newRevealed playing =
    playing.uniqueLetters
        |> (\u -> Set.diff u newRevealed)
        |> Set.isEmpty


applyFailure : PlayingModel -> PlayingModel
applyFailure playing =
    if playing.remainingFailures > 0 then
        { playing | remainingFailures = playing.remainingFailures - 1 }

    else
        { playing | status = Lose }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Guess letter ->
            case model of
                Errored _ ->
                    model

                Playing playing ->
                    case playing.status of
                        Win ->
                            Errored "cannot guess after the game is won"

                        Lose ->
                            Errored "cannot guess after the game is lost"

                        Ongoing ->
                            if isNewSuccessfulGuess letter playing then
                                let
                                    newRevealed =
                                        Set.insert letter playing.revealed

                                    won =
                                        wonAfterReveal newRevealed playing

                                    newStatus =
                                        if won then
                                            Win

                                        else
                                            Ongoing
                                in
                                Playing { playing | revealed = newRevealed, status = newStatus }

                            else
                                Playing (applyFailure playing)



-- VIEW


maskedWord : Set Char -> String -> String
maskedWord revealed word =
    String.map
        (\c ->
            if Set.member c revealed then
                c

            else
                '_'
        )
        word


stateLabel : GameStatus -> String
stateLabel status =
    case status of
        Ongoing ->
            "Ongoing"

        Win ->
            "Win"

        Lose ->
            "Lose"


view : Model -> Html Msg
view model =
    case model of
        Errored message ->
            div [] [ p [] [ text message ] ]

        Playing playing ->
            div []
                [ dl []
                    [ dt [] [ text "State" ]
                    , dd [] [ text (stateLabel playing.status) ]
                    , dt [] [ text "Word" ]
                    , dd [] [ text (maskedWord playing.revealed playing.word) ]
                    , dt [] [ text "Remaining failures" ]
                    , dd [] [ text (String.fromInt playing.remainingFailures) ]
                    ]
                ]