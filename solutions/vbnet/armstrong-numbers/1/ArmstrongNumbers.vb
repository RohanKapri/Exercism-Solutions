Imports System

Public Module ArmstrongNumbers
    Public Function IsArmstrongNumber(ByVal number As Integer) As Boolean
        Dim intAsString As String = number.ToString()
        Dim sum As Integer = 0

        For Each s As Char In intAsString
            sum += CInt(Math.Pow(CInt(Char.GetNumericValue(s)), intAsString.Length))
        Next

        Return sum = number
    End Function
End Module