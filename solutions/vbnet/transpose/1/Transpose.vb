Imports System.Text

Public Module Transpose

    Public Function Text(ByVal input As String) As String

        Dim rows As String() = input.Split(vbLf)
        Dim maxLineLenght As Integer = rows.Max(Function(s) s.Length)
        Dim lines = rows.Select(Function(r, i) r.PadRight(rows.Skip(i).Max(Function(row) row.Length))).ToArray

        Dim sb As New StringBuilder

        For i As Integer = 0 To maxLineLenght - 1
            For Each line In lines
                If i < line.Length Then sb.Append(line(i))
            Next
            If i < maxLineLenght - 1 Then sb.Append(vbLf)
        Next

        Return sb.ToString

    End Function

End Module