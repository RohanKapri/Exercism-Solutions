Imports System.Text

Public Class SimpleCipher
    Private ReadOnly numberOfCharactersInAlphabet As Integer = Asc("z") - Asc("a") + 1
    Public Property Key As String

    Public Sub New(key As String)
        Me.Key = key
    End Sub

    Public Sub New()
        Key = RandomKeyGenerator(100)
    End Sub

    Public Function Encode(plaintext As String) As String
        Return ShiftCipher(plaintext, Function(x, y, z) x + y >= z, Function(x, y, z) (x + y) Mod z)
    End Function

    Public Function Decode(ciphertext As String) As String
        Return ShiftCipher(ciphertext, Function(x, y, z) x - y < z, Function(x, y, z) x - y + z)
    End Function

    Private Function ShiftCipher(str As String, check As Func(Of Integer, Integer, Integer, Boolean), shift As Func(Of Integer, Integer, Integer, Integer)) As String
        Dim output As New StringBuilder(str)
        Dim j As Integer = 0

        For i As Integer = 0 To output.Length - 1
            If j = Key.Length Then
                j = 0
            End If

            Dim normalizeTextChar As Integer = Asc(output(i)) - Asc("a")
            Dim normalizeKeyChar As Integer = Asc(Key(j)) - Asc("a")
            Dim codedChar As Integer = If(check(normalizeTextChar, normalizeKeyChar, 0), shift(normalizeTextChar, normalizeKeyChar, numberOfCharactersInAlphabet), shift(normalizeTextChar, normalizeKeyChar, 0))
            output(i) = Chr(Asc("a") + codedChar)
            j += 1
        Next

        Return output.ToString()
    End Function

    Private Shared Function RandomKeyGenerator(keyLength As Integer) As String
        Dim rnd As New Random()
        Dim key As New StringBuilder()

        For i As Integer = 0 To keyLength - 1
            key.Append(Chr(rnd.Next(Asc("a"), Asc("z") + 1)))
        Next

        Return key.ToString()
    End Function
End Class