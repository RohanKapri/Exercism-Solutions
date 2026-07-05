Imports System
Imports System.Collections

Public Module FlattenArray
    Public Iterator Function Flatten(input As IEnumerable) As IEnumerable
        For Each i As Object In input
            If TypeOf i Is IEnumerable Then
                For Each v As Object In Flatten(DirectCast(i, IEnumerable))
                    Yield v
                Next
            ElseIf i IsNot Nothing Then
                Yield i
            End If
        Next
    End Function
End Module