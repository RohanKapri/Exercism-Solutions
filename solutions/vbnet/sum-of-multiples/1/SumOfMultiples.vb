Imports System
Imports System.Collections.Generic
Imports System.Linq

Public Module SumOfMultiples
    Public Function Sum(ByVal multiples As IEnumerable(Of Integer), ByVal max As Integer) As Integer
        Return Enumerable.Range(0, max).Where(Function(item) multiples.Any(Function(item2) (item2 <> 0) AndAlso item Mod item2 = 0)).Sum()
    End Function
End Module