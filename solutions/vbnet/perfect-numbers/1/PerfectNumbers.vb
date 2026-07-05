Imports System.Linq

Public Enum Classification
    Perfect = 0
    Abundant = 1
    Deficient = -1
End Enum

Public Module PerfectNumbers
    Public Function Classify(ByVal number As Integer) As Classification
        Return Enumerable.Where(Enumerable.Range(1, number - 1), Function(i) number Mod i = 0).Sum.CompareTo(number)
    End Function
End Module