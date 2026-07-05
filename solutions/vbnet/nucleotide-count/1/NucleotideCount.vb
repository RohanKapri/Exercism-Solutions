Imports System
Imports System.Collections.Generic
Imports System.Linq

Public Module NucleotideCount
    Public Function Count(ByVal sequence As String) As IDictionary(Of Char, Integer)
        If Not sequence.All(Function(c) "ACGT".Contains(c)) Then Throw New ArgumentException()
        Return (sequence & "ACGT").GroupBy(Function(x) x).ToDictionary(Function(g) g.Key, Function(g) g.Count() - 1)
    End Function
End Module