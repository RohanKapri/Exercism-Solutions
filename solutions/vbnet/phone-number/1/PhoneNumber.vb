Imports System
Imports System.Linq
Imports System.Text.RegularExpressions

Public Class PhoneNumber
    Public Shared Function Clean(ByVal phoneNumber As String) As String
        Dim match = Regex.Match(String.Concat(phoneNumber.Where(AddressOf Char.IsDigit)), "^1?([2-9]\d\d[2-9]\d{6})$")
        Return If(match.Success, match.Groups(1).ToString(), VisualBasicImpl.__Throw(Of System.String)(New ArgumentException()))
    End Function

    Private Class VisualBasicImpl
        <Obsolete("Please refactor calling code to use normal throw statements")>
        Shared Function __Throw(Of T)(ByVal e As Exception) As T
            Throw e
        End Function
    End Class
End Class