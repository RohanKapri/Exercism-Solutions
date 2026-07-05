Imports System.Collections.Generic

Public Module FoodChain
    Private ReadOnly animals As New Dictionary(Of Integer, String) From {
        {0, "fly"},
        {1, "spider"},
        {2, "bird"},
        {3, "cat"},
        {4, "dog"},
        {5, "goat"},
        {6, "cow"},
        {7, "horse"}
    }

    Private ReadOnly lines As New Dictionary(Of Integer, String) From {
        {1, "It wriggled and jiggled and tickled inside her." & vbLf},
        {2, "How absurd to swallow a bird!" & vbLf},
        {3, "Imagine that, to swallow a cat!" & vbLf},
        {4, "What a hog, to swallow a dog!" & vbLf},
        {5, "Just opened her throat and swallowed a goat!" & vbLf},
        {6, "I don't know how she swallowed a cow!" & vbLf},
        {7, "She's dead, of course!"}
    }

    Public Function Recite(ByVal verseNumber As Integer) As String
        Dim result = String.Empty
        Dim endLine = "I don't know why she swallowed the fly. Perhaps she'll die."
        result += $"I know an old lady who swallowed a {animals(verseNumber - 1)}." & vbLf
        If verseNumber <> 1 Then
            result += lines(verseNumber - 1)
        End If

        For key As Integer = verseNumber - 1 To 1 Step -1
            If verseNumber <> 1 AndAlso verseNumber <> 8 Then
                If verseNumber >= 3 AndAlso key = verseNumber - (verseNumber - 2) Then
                    result += $"She swallowed the {animals(key)} to catch the {animals(key - 1)} that wriggled and jiggled and tickled inside her." & vbLf
                Else
                    result += $"She swallowed the {animals(key)} to catch the {animals(key - 1)}." & vbLf
                End If
            End If
        Next

        If verseNumber <> 8 Then
            result += endLine
        End If

        Return result
    End Function

    Public Function Recite(ByVal startVerse As Integer, ByVal endVerse As Integer) As String
        Dim result = String.Empty
        Const breakVerse = vbLf & vbLf

        For verseNumber As Integer = startVerse To endVerse
            If verseNumber <> endVerse Then
                result += Recite(verseNumber) & breakVerse
            Else
                result += Recite(verseNumber)
            End If
        Next

        Return result
    End Function
End Module