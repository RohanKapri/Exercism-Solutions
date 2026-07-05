Imports System
Imports System.Collections.Generic

Public Module House
    Public Function Recite(ByVal verseNumber As Integer) As String
        Dim phrases As List(Of KeyValuePair(Of String, String)) = GetPhrases()
        
        Dim result As String = $"This is the {phrases(verseNumber - 1).Value}"

        For i As Integer = verseNumber - 1 To 0 + 1 Step -1
            result += $" that {phrases(i - 1).Key} the {phrases(i - 1).Value}"
        Next

        Return result & "."
    End Function

    Public Function Recite(ByVal startVerse As Integer, ByVal endVerse As Integer) As String
        Dim recitedVerses As String = Recite(startVerse)

        For i As Integer = startVerse + 1 To endVerse
            recitedVerses += (vbLf & Recite(i))
        Next

        Return recitedVerses
    End Function

    Private Function GetPhrases() As List(Of KeyValuePair(Of String, String))
        Return New List(Of KeyValuePair(Of String, String))() From {
            New KeyValuePair(Of String, String)("lay in", "house that Jack built"),
            New KeyValuePair(Of String, String)("ate", "malt"),
            New KeyValuePair(Of String, String)("killed", "rat"),
            New KeyValuePair(Of String, String)("worried", "cat"),
            New KeyValuePair(Of String, String)("tossed", "dog"),
            New KeyValuePair(Of String, String)("milked", "cow with the crumpled horn"),
            New KeyValuePair(Of String, String)("kissed", "maiden all forlorn"),
            New KeyValuePair(Of String, String)("married", "man all tattered and torn"),
            New KeyValuePair(Of String, String)("woke", "priest all shaven and shorn"),
            New KeyValuePair(Of String, String)("kept", "rooster that crowed in the morn"),
            New KeyValuePair(Of String, String)("belonged to", "farmer sowing his corn"),
            New KeyValuePair(Of String, String)("", "horse and the hound and the horn")
        }
    End Function
End Module