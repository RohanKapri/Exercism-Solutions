Imports System
Imports System.Linq
Imports System.Text.RegularExpressions

Public Module RotationalCipher
    Private Function RotateChar(c As Char, shiftKey As Integer) As Char
        If Not Char.IsLetter(c) Then
            Return c
        End If
        Dim b As Integer = If(Char.IsLower(c), AscW("a"c), AscW("A"c))
        Return ChrW(b + ((AscW(c) - b + shiftKey) Mod 26))
    End Function

    Public Function Rotate(text As String, shiftKey As Integer) As String
        Return New String(text.Select(Function(c) RotateChar(c, shiftKey)).ToArray())
    End Function
End Module