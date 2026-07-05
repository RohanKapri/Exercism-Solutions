Imports System

Public Module Triangle
    Public Function IsScalene(ByVal side1 As Double, ByVal side2 As Double, ByVal side3 As Double) As Boolean
        Return IsTriangle(side1, side2, side3) AndAlso Not IsEquilateral(side1, side2, side3) AndAlso Not IsIsosceles(side1, side2, side3)
    End Function

    Public Function IsIsosceles(ByVal side1 As Double, ByVal side2 As Double, ByVal side3 As Double) As Boolean
        Return IsTriangle(side1, side2, side3) AndAlso (side1 = side2 OrElse side2 = side3 OrElse side3 = side1)
    End Function

    Public Function IsEquilateral(ByVal side1 As Double, ByVal side2 As Double, ByVal side3 As Double) As Boolean
        Return IsTriangle(side1, side2, side3) AndAlso Math.Pow(side1, 2) + Math.Pow(side2, 2) = 2 * Math.Pow(side3, 2)
    End Function

    Private Function IsTriangle(ByVal side1 As Double, ByVal side2 As Double, ByVal side3 As Double) As Boolean
        Return (side1 > 0 AndAlso side2 > 0 AndAlso side3 > 0) AndAlso side1 + side2 >= side3 AndAlso side2 + side3 >= side1 AndAlso side3 + side1 >= side2
    End Function
End Module