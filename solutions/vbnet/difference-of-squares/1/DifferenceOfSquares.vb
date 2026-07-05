Imports System

Public Module DifferenceOfSquares
    Public Function CalculateSquareOfSum(ByVal max As Integer) As Integer
        Return CInt(Math.Pow((max * (max + 1)) / 2, 2))
    End Function

    Public Function CalculateSumOfSquares(ByVal max As Integer) As Integer
        Return (max * (max + 1) * (2 * max + 1)) \ 6
    End Function

    Public Function CalculateDifferenceOfSquares(ByVal max As Integer) As Integer
        Return Math.Abs(CalculateSumOfSquares(max) - CalculateSquareOfSum(max))
    End Function
End Module