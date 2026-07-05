Imports System
Imports System.Collections.Generic
Imports System.Linq

Public Module PythagoreanTriplet
    Public Iterator Function TripletsWithSum(ByVal sum As Integer) As IEnumerable(Of (a As Integer, b As Integer, c As Integer))
        For a As Integer = 1 To sum \ 3
            For b As Integer = a + 1 To sum \ 2
                If a * a + b * b = (sum - a - b) * (sum - a - b) Then
                    Yield (a, b, sum - a - b)
                End If
            Next
        Next
    End Function
End Module