Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Text.RegularExpressions

Public Module Poker
    Private ReadOnly combinations As New Dictionary(Of String, Integer) From {
        {"1,1", 0},
        {"2,1", 1},
        {"2,2", 2},
        {"3,1", 3},
        {"3,2", 6},
        {"4,1", 7}
    }

    Public Function BestHands(ByVal hands As IEnumerable(Of String)) As IEnumerable(Of String)
        Dim rankingHands = hands.Select(Function(card) New With {.Card = card, .Rank = HandRank(card)}).ToArray()
        Dim maxRank = rankingHands.Max(Function(hand) hand.Rank)
        Return rankingHands.Where(Function(pair) pair.Rank.Equals(maxRank)).Select(Function(pair) pair.Card).ToArray()
    End Function

    Private Function HandRank(ByVal hand As String) As Tuple(Of Integer, Integer)
        Dim cards = hand.Split().Select(Function(card) New Card(card)).ToArray()
        Dim ranks = HandRanks(cards)
        Dim results = ranks.GroupBy(Function(z) z) _
            .Select(Function(gr) New With {.Rank = gr.Key, .Count = gr.Count()}) _
            .OrderByDescending(Function(x) x.Count) _
            .ThenByDescending(Function(x) x.Rank) _
            .ToArray()
        Dim combination = String.Join(",", results.Take(2).Select(Function(x) x.Count))
        Dim rest = results.Select(Function(x) x.Rank).Aggregate(Function(acc, x) acc * 14 + x)
        Dim first = combinations(combination)

        If IsFlash(cards) Then
            first += 5
        End If

        If IsStraight(ranks) Then
            first += 4
        End If

        Return Tuple.Create(first, rest)
    End Function

    Private Function IsStraight(ByVal ranks As Integer()) As Boolean
        Return New HashSet(Of Integer)(ranks).Count = 5 AndAlso ranks.Max() - ranks.Min() = 4
    End Function

    Private Function IsFlash(ByVal cards As IEnumerable(Of Card)) As Boolean
        Return New HashSet(Of String)(cards.Select(Function(card) card.Suit)).Count = 1
    End Function

    Private Function HandRanks(ByVal cards As IEnumerable(Of Card)) As Integer()
        Dim ranks = cards.Select(Function(card) card.Rank) _
            .OrderByDescending(Function(x) x) _
            .ToArray()

        If Enumerable.SequenceEqual(ranks, {14, 5, 4, 3, 2}) Then
            Return {1, 2, 3, 4, 5}
        End If

        Return ranks
    End Function

    Private Class Card
        Private Shared cardPattern As New Regex("(?<rank>\d+|[JQKA])(?<suit>[HSCD])")

        Public Sub New(ByVal card As String)
            Dim match = cardPattern.Match(card)
            If Not match.Success Then
                Throw New ArgumentOutOfRangeException(NameOf(card), card)
            End If

            Dim rank = match.Groups("rank").Value
            Me.Rank = If(Integer.TryParse(rank, Nothing), CInt(rank), "--23456789TJQKA".IndexOf(rank))
            Me.Suit = match.Groups("suit").Value
        End Sub

        Public ReadOnly Property Rank As Integer
        Public ReadOnly Property Suit As String

        Public Overrides Function ToString() As String
            Return $"Rank = {Rank}, Suit = {Suit}"
        End Function
    End Class
End Module