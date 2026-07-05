Imports System
Imports System.Collections.Generic
Imports System.Linq

Public Enum YachtCategory
    Ones = 1
    Twos = 2
    Threes = 3
    Fours = 4
    Fives = 5
    Sixes = 6
    FullHouse = 7
    FourOfAKind = 8
    LittleStraight = 9
    BigStraight = 10
    Choice = 11
    Yacht = 12
End Enum

Public Module YachtGame
    Private s_Calculators As Dictionary(Of YachtCategory, Func(Of Integer(), Integer)) = New Dictionary(Of YachtCategory, Func(Of Integer(), Integer)) From {
        {YachtCategory.Ones, Function(d) d.Count(Function(i) i = 1)},
        {YachtCategory.Twos, Function(d) d.Count(Function(i) i = 2) * 2},
        {YachtCategory.Threes, Function(d) d.Count(Function(i) i = 3) * 3},
        {YachtCategory.Fours, Function(d) d.Count(Function(i) i = 4) * 4},
        {YachtCategory.Fives, Function(d) d.Count(Function(i) i = 5) * 5},
        {YachtCategory.Sixes, Function(d) d.Count(Function(i) i = 6) * 6},
        {YachtCategory.FullHouse, Function(d) If(d.GroupBy(Function(i) i).All(Function(g) {2, 3}.Contains(g.Count())), d.Sum(), 0)},
        {YachtCategory.FourOfAKind, Function(d) If(d.GroupBy(Function(i) i).FirstOrDefault(Function(g) g.Count() >= 4)?.Key * 4, 0)},
        {YachtCategory.LittleStraight, Function(d) If(d.OrderBy(Function(i) i).Distinct().Count() = 5 AndAlso d.OrderBy(Function(i) i).Distinct().Sum() = 15, 30, 0)},
        {YachtCategory.BigStraight, Function(d) If(d.OrderBy(Function(i) i).Distinct().Count() = 5 AndAlso d.OrderBy(Function(i) i).Distinct().Sum() = 20, 30, 0)},
        {YachtCategory.Choice, Function(d) d.Sum()},
        {YachtCategory.Yacht, Function(d) If(d.All(Function(i) i = d(0)), 50, 0)}
    }

    Public Function Score(ByVal dice As Integer(), ByVal category As YachtCategory) As Integer
        Return s_Calculators(category)(dice)
    End Function
End Module