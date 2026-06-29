using System;
using System.Collections.Generic;
using System.Linq;

public static class Camicia
{
    public enum GameStatus
    {
        Finished,
        Loop
    }

    public record GameResult(GameStatus Status, int Tricks, int Cards);

    public static GameResult SimulateGame(string[] playerA, string[] playerB)
    {
        var deckA = new Queue<string>(playerA);
        var deckB = new Queue<string>(playerB);
        var pile = new List<string>();

        int cardsPlayed = 0;
        int tricks = 0;

        int player = 0;
        int penalty = 0;
        int lastFacePlayer = -1;

        var seen = new HashSet<string>();

        while (true)
        {
            // LOOP CHECK (solo al inicio de ronda)
            if (penalty == 0 && pile.Count == 0)
            {
                string state = Serialize(deckA, deckB, player, penalty);

                if (!seen.Add(state))
                    return new GameResult(GameStatus.Loop, tricks, cardsPlayed);
            }

            var deck = player == 0 ? deckA : deckB;

            if (deck.Count == 0)
            {
                var winner = player == 0 ? deckB : deckA;
                Collect(winner, pile);
                tricks++;

                if (deckA.Count == 0 || deckB.Count == 0)
                    return new GameResult(GameStatus.Finished, tricks, cardsPlayed);

                player = lastFacePlayer;
                continue;
            }

            var card = deck.Dequeue();
            pile.Add(card);
            cardsPlayed++;

            int p = Penalty(card);

            if (p > 0)
            {
                penalty = p;
                lastFacePlayer = player;
                player = 1 - player;
                continue;
            }

            if (penalty > 0)
            {
                penalty--;

                if (penalty == 0)
                {
                    var winner = lastFacePlayer == 0 ? deckA : deckB;
                    Collect(winner, pile);
                    tricks++;

                    if (deckA.Count == 0 || deckB.Count == 0)
                        return new GameResult(GameStatus.Finished, tricks, cardsPlayed);

                    player = lastFacePlayer;
                }
            }
            else
            {
                player = 1 - player;
            }
        }
    }

    static int Penalty(string card)
    {
        return card switch
        {
            "J" => 1,
            "Q" => 2,
            "K" => 3,
            "A" => 4,
            _ => 0
        };
    }

    static void Collect(Queue<string> deck, List<string> pile)
    {
        foreach (var c in pile)
            deck.Enqueue(c);

        pile.Clear();
    }

    // NUEVO SERIALIZE (corrige los loops falsos)
    static string Serialize(Queue<string> a, Queue<string> b, int player, int penalty)
    {
        string sa = string.Join(",", a.Select(Normalize));
        string sb = string.Join(",", b.Select(Normalize));

        return $"{player}:{penalty}:{sa}|{sb}";
    }

    static string Normalize(string card)
    {
        return card switch
        {
            "J" => "J",
            "Q" => "Q",
            "K" => "K",
            "A" => "A",
            _ => "N"
        };
    }
}