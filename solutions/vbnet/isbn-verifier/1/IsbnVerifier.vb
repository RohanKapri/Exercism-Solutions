Imports System.Collections.Generic
Imports System.Linq
Imports System.Text.RegularExpressions

Public Module IsbnVerifier
    Private Const IsbnPattern As String = "^\d(-?)\d{3}\1\d{5}\1[\dX]$"

    Public Function IsValid(ByVal number As String) As Boolean
        Return IsIsbnPattern(number) AndAlso IsValidIsbnCheckSum(number)
    End Function

    Private Function IsIsbnPattern(ByVal number As String) As Boolean
        Return Regex.IsMatch(number, IsbnPattern)
    End Function

    Private Function IsValidIsbnCheckSum(ByVal number As String) As Boolean
        Return GetIsbnCheckSum(number) Mod 11 = 0
    End Function

    Private Function GetIsbnCheckSum(ByVal number As String) As Integer
        Return IsbnDigits(number).Select(Function(x, i) x * (10 - i)).Sum()
    End Function

    Private Function IsbnDigits(ByVal number As String) As IEnumerable(Of Integer)
        Return number.Where(Function(c) Char.IsLetterOrDigit(c)).Select(Function(x) If(x = "X"c, 10, Integer.Parse(x.ToString())))
    End Function
End Module