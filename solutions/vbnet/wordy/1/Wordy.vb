Imports System
Imports System.Data
Imports System.Text
Imports System.Collections.Generic
Imports System.Text.RegularExpressions

Public Module Wordy
    Public Function Answer(ByVal question As String) As Integer
        Dim sb = New StringBuilder()
        Dim dt = New DataTable()
        Dim lastValueIsNumber = False
        Dim bracketCounter = 0
        Dim tokens As Dictionary(Of String, String) = New Dictionary(Of String, String)() From {
            {"plus", "+"},
            {"minus", "-"},
            {"multiplied", "*"},
            {"divided", "/"},
            {"cubed", ""}
        }

        For Each str As String In question.Replace("?"c, " "c).Trim().Split(" "c)

            If Regex.IsMatch(str, "[0-9]") Then

                If lastValueIsNumber = False Then
                    sb.Append(str)
                    bracketCounter += 1
                Else
                    Throw New ArgumentException()
                End If

                lastValueIsNumber = True
            ElseIf tokens.ContainsKey(str) Then

                If lastValueIsNumber = True AndAlso tokens(str) <> "cubed" Then
                    sb.Append(tokens(str))
                    bracketCounter += 1
                Else
                    Throw New ArgumentException()
                End If

                lastValueIsNumber = False
            End If

            If bracketCounter <> 0 AndAlso bracketCounter Mod 3 = 0 Then
                sb.Insert(0, "(")
                sb.Append(")")
            End If
        Next

        Console.WriteLine(sb.ToString())
        If String.IsNullOrWhiteSpace(sb.ToString()) OrElse Not lastValueIsNumber Then Throw New ArgumentException()
        Return Convert.ToInt32(dt.Compute(sb.ToString(), ""))
    End Function
End Module

