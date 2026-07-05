Imports System
Imports System.Linq

Public Module Luhn
    Public Function IsValid(ByVal number As String) As Boolean
        If Not number.All(Function(c) Char.IsDigit(c) OrElse Char.IsWhiteSpace(c)) Then Return False
        If number.Trim().Length < 2 Then Return False
          
        Return number.Reverse().Where(AddressOf Char.IsDigit).[Select](Function(c) CInt(Char.GetNumericValue(c))).[Select](Function(n, i) If(((i Mod 2) = 0), n, n * 2)).[Select](Function(n) If(n > 9, n - 9, n)).Sum() Mod 10 = 0
    End Function
End Module