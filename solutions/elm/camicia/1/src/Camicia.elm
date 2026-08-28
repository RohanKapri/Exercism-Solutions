module Camicia exposing (Card(..), Status(..), simulateGame)

import Set exposing (Set)


type Card
    = Ace
    | Two
    | Three
    | Four
    | Five
    | Six
    | Seven
    | Eight
    | Nine
    | Ten
    | Jack
    | Queen
    | King


type Status
    = Finished
    | Loop


type Player
    = PA
    | PB


type Phase
    = Normal Player
    | Penalty { attacker : Player, defender : Player, owe : Int }


type alias World =
    { seen : Set String
    , a : List Card
    , b : List Card
    , pile : List Card
    , phase : Phase
    , played : Int
    , tricks : Int
    }


type Outcome
    = Done { status : Status, cards : Int, tricks : Int }
    | Next World


penaltyOwe : Card -> Maybe Int
penaltyOwe c =
    case c of
        Jack ->
            Just 1

        Queen ->
            Just 2

        King ->
            Just 3

        Ace ->
            Just 4

        _ ->
            Nothing


other : Player -> Player
other p =
    case p of
        PA ->
            PB

        PB ->
            PA


getHand : Player -> List Card -> List Card -> List Card
getHand p handA handB =
    case p of
        PA ->
            handA

        PB ->
            handB


putHand : Player -> List Card -> ( List Card, List Card ) -> ( List Card, List Card )
putHand p new ( handA, handB ) =
    case p of
        PA ->
            ( new, handB )

        PB ->
            ( handA, new )


normalizeChar : Card -> Char
normalizeChar c =
    case c of
        Jack ->
            'J'

        Queen ->
            'Q'

        King ->
            'K'

        Ace ->
            'A'

        _ ->
            'N'


stateKey : List Card -> List Card -> Player -> String
stateKey handA handB turn =
    String.fromList (List.map normalizeChar handA)
        ++ "|"
        ++ String.fromList (List.map normalizeChar handB)
        ++ "|"
        ++ (case turn of
                PA ->
                    "A"

                PB ->
                    "B"
           )


tick : World -> Outcome
tick w =
    case w.phase of
        Normal toMove ->
            if w.pile == [] then
                let
                    k =
                        stateKey w.a w.b toMove
                in
                if Set.member k w.seen then
                    Done { status = Loop, cards = w.played, tricks = w.tricks }

                else
                    normalPlay { w | seen = Set.insert k w.seen } toMove

            else
                normalPlay w toMove

        Penalty pen ->
            penaltyPlay w pen


normalPlay : World -> Player -> Outcome
normalPlay w toMove =
    case getHand toMove w.a w.b of
        [] ->
            collectTrick w (other toMove)

        c :: rest ->
            let
                ( a1, b1 ) =
                    putHand toMove rest ( w.a, w.b )

                pile1 =
                    c :: w.pile

                played1 =
                    w.played + 1

                w1 =
                    { w | a = a1, b = b1, pile = pile1, played = played1 }
            in
            case penaltyOwe c of
                Just n ->
                    Next { w1 | phase = Penalty { attacker = toMove, defender = other toMove, owe = n } }

                Nothing ->
                    Next { w1 | phase = Normal (other toMove) }


penaltyPlay : World -> { attacker : Player, defender : Player, owe : Int } -> Outcome
penaltyPlay w { attacker, defender, owe } =
    case getHand defender w.a w.b of
        [] ->
            collectTrick w attacker

        c :: rest ->
            let
                ( a1, b1 ) =
                    putHand defender rest ( w.a, w.b )

                pile1 =
                    c :: w.pile

                played1 =
                    w.played + 1

                w1 =
                    { w | a = a1, b = b1, pile = pile1, played = played1 }
            in
            case penaltyOwe c of
                Just n ->
                    Next { w1 | phase = Penalty { attacker = defender, defender = attacker, owe = n } }

                Nothing ->
                    let
                        owe1 =
                            owe - 1
                    in
                    if owe1 == 0 then
                        collectTrick w1 attacker

                    else
                        Next { w1 | phase = Penalty { attacker = attacker, defender = defender, owe = owe1 } }


collectTrick : World -> Player -> Outcome
collectTrick w winner =
    let
        wHand =
            getHand winner w.a w.b

        merged =
            wHand ++ List.reverse w.pile

        ( a1, b1 ) =
            putHand winner merged ( w.a, w.b )

        tricks1 =
            w.tricks + 1

        w1 =
            { w | a = a1, b = b1, pile = [], tricks = tricks1 }
    in
    if a1 == [] || b1 == [] then
        Done { status = Finished, cards = w.played, tricks = tricks1 }

    else
        Next { w1 | phase = Normal winner }


{-| Batched ticks per outer step. Tail-recursive `stepMany` avoids allocating `List.range` every batch.
-}
chunkSize : Int
chunkSize =
    12000


{-| Run up to `chunkSize` transitions without building an intermediate list (faster than foldl + range on long runs).
-}
stepChunk : World -> Outcome
stepChunk w =
    stepMany chunkSize (Next w)


stepMany : Int -> Outcome -> Outcome
stepMany n outcome =
    if n <= 0 then
        outcome
    else
        case outcome of
            Done _ ->
                outcome

            Next wacc ->
                stepMany (n - 1) (tick wacc)


{-| Tail-recursive outer loop; depth is at most (total ticks / chunkSize), safe for long games.
-}
runAll : World -> { status : Status, cards : Int, tricks : Int }
runAll w =
    case stepChunk w of
        Done r ->
            r

        Next w2 ->
            runAll w2


simulateGame : List Card -> List Card -> { status : Status, cards : Int, tricks : Int }
simulateGame deckA0 deckB0 =
    runAll
        { seen = Set.empty
        , a = deckA0
        , b = deckB0
        , pile = []
        , phase = Normal PA
        , played = 0
        , tricks = 0
        }