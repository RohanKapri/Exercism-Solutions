Imports System
Imports System.Collections.Generic
Imports System.Linq

Public Module Raindrops
    Private sounds As IDictionary(Of Integer, String) = New Dictionary(Of Integer, String) From {
        {3, "Pling"},
        {5, "Plang"},
        {7, "Plong"}
    }

    Public Function Convert(number As Integer) As String
        Return String.Join("", sounds.Where(Function(x) number Mod x.Key = 0) _
                                     .Select(Function(x) x.Value) _
                                     .DefaultIfEmpty(number.ToString()))
    End Function
End Module