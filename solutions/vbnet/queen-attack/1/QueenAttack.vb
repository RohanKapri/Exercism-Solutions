Imports System
Imports System.Linq

Public Class Queen
    Public Sub New(row As Integer, column As Integer)
        Me.Row = row
        Me.Column = column
    End Sub

    Public ReadOnly Property Row As Integer
    Public ReadOnly Property Column As Integer
End Class

Public Module QueenAttack
    Public Function CanAttack(white As Queen, black As Queen) As Boolean
        ' Initialize the chessboard array
        Dim chessboard(7, 7) As Char

        ' Place the queens on the chessboard
        chessboard(white.Row, white.Column) = "W"
        chessboard(black.Row, black.Column) = "B"

        ' Check if queens are in the same row or column
        If white.Row = black.Row OrElse white.Column = black.Column Then
            Return True
        End If

        ' Check if queens are on the same diagonal using LINQ
        Dim isBlackOnDiagonal = From row In Enumerable.Range(0, 8)
                               From col In Enumerable.Range(0, 8)
                               Where chessboard(row, col) = "B" AndAlso isOnDiagonal(row, col, white)
                               Select True

        Return isBlackOnDiagonal.Any()
    End Function

    ' Function to check if a cell is on the same diagonal
    Public Function isOnDiagonal(row As Integer, col As Integer, whiteQueen As Queen) As Boolean
        Return Math.Abs(whiteQueen.Row - row) = Math.Abs(whiteQueen.Column - col)
    End Function

    Public Function Create(row As Integer, column As Integer) As Queen
        If row >= 0 AndAlso row < 8 AndAlso column >= 0 AndAlso column < 8 Then
            Return New Queen(row, column)
        End If

        Throw New ArgumentOutOfRangeException()
    End Function
End Module