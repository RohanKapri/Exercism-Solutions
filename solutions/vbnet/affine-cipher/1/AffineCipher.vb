Imports System
Imports System.Linq
Imports System.Text
Imports System.Collections.Generic

Public Module AffineCipher
    Private Const Alphabet As Integer = 26
    Private Const ChunkSize As Integer = 5

    Public Function Encode(ByVal plainText As String, ByVal a As Integer, ByVal b As Integer) As String
        If Not IsCoprime(a, Alphabet) Then
            Throw New ArgumentException("Numbers must be coprime")
        End If

        Dim encoded = plainText.ToLower().Where(Function(x) Char.IsLetterOrDigit(x)) _
                                         .Select(Function(x) If(Char.IsDigit(x), x, ToChar((a * Index(x) + b) Mod Alphabet)))

        Return String.Join(" ", encoded.Chunk(ChunkSize).Select(Function(x) New String(x.ToArray())))
    End Function

    Private Iterator Function Chunk(ByVal source As IEnumerable(Of Char), ByVal size As Integer) As IEnumerable(Of IEnumerable(Of Char))
        While source.Any()
            Yield source.Take(size)
            source = source.Skip(size)
        End While
    End Function

    Public Function Decode(ByVal cipheredText As String, ByVal a As Integer, ByVal b As Integer) As String
        If Not IsCoprime(a, Alphabet) Then
            Throw New ArgumentException("Numbers must be coprime")
        End If

        Return New String(cipheredText.Where(Function(x) Char.IsLetterOrDigit(x)) _
                                      .Select(Function(x) If(Char.IsDigit(x), x, DecodeSymbol(x, a, b))) _
                                      .ToArray())
    End Function

    Private Function DecodeSymbol(ByVal c As Char, ByVal a As Integer, ByVal b As Integer) As Char
        Dim value = Mmi(a) * (Index(c) - b) Mod Alphabet
        If value < 0 Then value += Alphabet
        Return ToChar(value)
    End Function

    Private Function Mmi(ByVal a As Integer) As Integer
        Return Enumerable.Range(1, Alphabet).First(Function(x) (a * x Mod Alphabet) = 1)
    End Function

    Private Function Index(ByVal c As Char) As Integer
        Return AscW(c) - AscW("a"c)
    End Function

    Private Function ToChar(ByVal i As Integer) As Char
        Return ChrW(AscW("a"c) + i)
    End Function

    Private Function IsCoprime(ByVal a As Integer, ByVal m As Integer) As Boolean
        If a = 0 Then
            Return m = 1
        Else
            Return IsCoprime(m Mod a, a)
        End If
    End Function
End Module