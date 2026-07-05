Imports System

Public Module Darts
    Public Function Score(ByVal x As Double, ByVal y As Double) As Integer
        Select Case Distance(x, y)
            Case <= 1.0
                Return 10
            Case <= 5.0
                Return 5
            Case <= 10.0
                Return 1
            Case Else
                Return 0
        End Select
    End Function

    Private Function Distance(ByVal x As Double, ByVal y As Double) As Double
        Return Math.Sqrt(x * x + y * y)
    End Function
End Module