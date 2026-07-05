Public Class Anagram

    Private _baseWord As String
    Private _baseWordSorted As String
  
    Public Sub New(baseWord As String)
        _baseWord = baseWord.ToLower
        _baseWordSorted = SortString(_baseWord)
    End Sub

    Public Function Match(potentialMatches As String()) As String()

        Dim subset As New List(Of String)
        Dim result() As String

        For Each stPotentialMatch As String In potentialMatches

            Dim stPotentialMatchLower As String = stPotentialMatch.ToLower

            If stPotentialMatchLower <> _baseWord Then         'not same word
                If IsAnagram(stPotentialMatchLower) Then
                    subset.Add(stPotentialMatch)
                End If
            End If

        Next

        result = subset.ToArray
        Array.Sort(result)

        Return result

    End Function

    Private Function IsAnagram(word As String) As Boolean

        Return _baseWordSorted = SortString(word)

    End Function
  
    Private Function SortString(word As String) As String

        Dim chars = word.ToCharArray()
        Array.Sort(chars)
        Return New String(chars)

    End Function

End Class