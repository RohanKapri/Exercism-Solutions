Imports System
Imports System.Linq

Public Module Acronym
    Public Function Abbreviate(ByVal phrase As String) As String
        Dim separators As Char() = {" "c, "-"c, "_"c}
        Dim abb = String.Join("", phrase.Split(separators, StringSplitOptions.RemoveEmptyEntries).Select(Function(x) x(0)))
        Return abb.ToUpper()
    End Function
End Module