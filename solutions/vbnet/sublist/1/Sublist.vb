Imports System
Imports System.Collections.Generic
Imports System.Linq

Public Enum SublistType
    Equal
    Unequal
    Superlist
    Sublist
End Enum

Public Module Sublist
    Public Function Classify(Of T As {IComparable})(ByVal list1 As List(Of T), ByVal list2 As List(Of T)) As SublistType
        If list1.SequenceEqual(list2) Then
            Return SublistType.Equal
        End If

        For i = 0 To Math.Abs(list1.Count - list2.Count)
            If list1.Count > list2.Count AndAlso list1.GetRange(i, list2.Count).SequenceEqual(list2) Then
                Return SublistType.Superlist
            End If

            If list1.Count < list2.Count AndAlso list2.GetRange(i, list1.Count).SequenceEqual(list1) Then
                Return SublistType.Sublist
            End If
        Next

        Return SublistType.Unequal
    End Function
End Module