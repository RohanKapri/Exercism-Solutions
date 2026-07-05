Imports System.Linq

Public Module Pangram
    Const alphabet As String = "abcdefghijklmnopqrstuvwxyz"

    Public Function IsPangram(ByVal input As String) As Boolean
        Return alphabet.All(AddressOf input.ToLower().Contains)
    End Function
End Module