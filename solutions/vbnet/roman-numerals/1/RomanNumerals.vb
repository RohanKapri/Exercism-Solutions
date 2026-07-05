Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Runtime.CompilerServices

Public Module RomanNumeralExtension
    Private data As New Dictionary(Of Integer, String()) From {
        {1, New String() {"", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"}},
        {10, New String() {"", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"}},
        {100, New String() {"", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"}},
        {1000, New String() {"", "M", "MM", "MMM"}}
    }

    <System.Runtime.CompilerServices.Extension()>
    Public Function ToRoman(ByVal value As Integer) As String
        Return value.ToString().Reverse().
            Select(Function(c, i) data(CInt(Math.Pow(10, i)))(CInt(Char.GetNumericValue(c)))).
            Reverse().
            Aggregate("", Function(a, b) a & b)
    End Function
End Module