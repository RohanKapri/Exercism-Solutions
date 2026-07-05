Imports System.Text

Public Module Diamond
    Public Function Rows(letter As String) As String

        Dim max As Integer = Asc(letter(0)) - Asc("A"c)
        Dim sb As New StringBuilder()

        For i As Integer = 0 To max * 2
            Dim row As Integer = If(i <= max, i, 2 * max - i)
            Dim ch As Char = Chr(Asc("A"c) + row)
            Dim outer As Integer = max - row
            Dim inner As Integer = 2 * row - 1

            sb.Append(New String(" "c, outer)).Append(ch)

            If row > 0 Then
                sb.Append(New String(" "c, inner)).Append(ch)
            End If

            sb.Append(New String(" "c, outer))

            If i < max * 2 Then sb.Append(vbCrLf)
        Next

        Return sb.ToString()

    End Function

End Module

