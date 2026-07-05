Imports System.Linq

Public Module Isogram
    Public Function IsIsogram(ByVal word As String) As Boolean
        Dim lowerLetters = word.ToLower().Where(AddressOf Char.IsLetter).ToList()
        Return lowerLetters.Distinct().Count() = lowerLetters.Count
    End Function
End Module