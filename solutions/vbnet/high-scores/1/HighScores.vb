Imports System
Imports System.Linq
Imports System.Collections.Generic

Public Class HighScores
    Private ReadOnly _list As List(Of Integer)

    Public Sub New(ByVal list As List(Of Integer))
        _list = list
    End Sub

    Public Function Scores() As List(Of Integer)
        Return _list
    End Function

    Public Function Latest() As Integer
        Return _list.Last()
    End Function

    Public Function PersonalBest() As Integer
        Return _list.Max()
    End Function

    Public Function PersonalTopThree() As List(Of Integer)
        Return _list.OrderByDescending(Function(score) score).Take(3).ToList()
    End Function

End Class