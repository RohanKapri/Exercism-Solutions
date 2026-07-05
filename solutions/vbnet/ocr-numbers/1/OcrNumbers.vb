Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Runtime.CompilerServices

Public Module OcrNumbers
    Private ReadOnly Property Numbers As IReadOnlyDictionary(Of String, Char)
        Get
            Return New Dictionary(Of String, Char)() From {
                {" _ " & "| |" & "|_|" & "   ", "0"c},
                {"   " & "  |" & "  |" & "   ", "1"c},
                {" _ " & " _|" & "|_ " & "   ", "2"c},
                {" _ " & " _|" & " _|" & "   ", "3"c},
                {"   " & "|_|" & "  |" & "   ", "4"c},
                {" _ " & "|_ " & " _|" & "   ", "5"c},
                {" _ " & "|_ " & "|_|" & "   ", "6"c},
                {" _ " & "  |" & "  |" & "   ", "7"c},
                {" _ " & "|_|" & "|_|" & "   ", "8"c},
                {" _ " & "|_|" & " _|" & "   ", "9"c}
            }
        End Get
    End Property

    <Extension()>
    Private Iterator Function ReadChars(ByVal lines As String(), ByVal row As Integer) As IEnumerable(Of Char)
        If lines(row).Length Mod 3 <> 0 Then Throw New ArgumentException()

        For col As Integer = 0 To lines(row).Length - 1 Step 3
            Dim number As String = lines(row + 0).Substring(col, 3) & lines(row + 1).Substring(col, 3) & lines(row + 2).Substring(col, 3) & lines(row + 3).Substring(col, 3)
            Yield If(Numbers.ContainsKey(number), Numbers(number), "?"c)
        Next
    End Function

    <Extension()>
    Private Iterator Function ReadLines(ByVal lines As String()) As IEnumerable(Of String)
        If lines.Length Mod 4 <> 0 Then Throw New ArgumentException()

        For row As Integer = 0 To lines.Length - 1 Step 4
            Yield String.Join("", lines.ReadChars(row))
        Next
    End Function

    Public Function Convert(ByVal input As String) As String
        Return String.Join(",", input.Split(vbLf).ReadLines())
    End Function
End Module