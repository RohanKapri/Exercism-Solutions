Imports System
Imports System.Collections.Generic
Imports System.Linq

Public Module TwelveDays
    Public ReadOnly verseItem As New Dictionary(Of Integer, (day As String, newItem As String)) From {
        {1, ("first", "a Partridge in a Pear Tree.")},
        {2, ("second", "two Turtle Doves")},
        {3, ("third", "three French Hens")},
        {4, ("fourth", "four Calling Birds")},
        {5, ("fifth", "five Gold Rings")},
        {6, ("sixth", "six Geese-a-Laying")},
        {7, ("seventh", "seven Swans-a-Swimming")},
        {8, ("eighth", "eight Maids-a-Milking")},
        {9, ("ninth", "nine Ladies Dancing")},
        {10, ("tenth", "ten Lords-a-Leaping")},
        {11, ("eleventh", "eleven Pipers Piping")},
        {12, ("twelfth", "twelve Drummers Drumming")}
    }

    Public Function Recite(ByVal verseNumber As Integer) As String
        If verseNumber < 1 OrElse verseNumber > 12 Then
            Throw New ArgumentOutOfRangeException("Verses must be between 1 and 12")
        End If

        Dim day As String = verseItem(verseNumber).day
        Dim newItem As String = verseItem(verseNumber).newItem

        Dim previousItems As IEnumerable(Of String) = Enumerable.Range(1, verseNumber - 1) _
            .Select(Function(verseIndex) If(verseIndex = 1, "and ", "") & verseItem(verseIndex).newItem) _
            .Append(newItem) _
            .Reverse()

        Return $"On the {day} day of Christmas my true love gave to me: {String.Join(", ", previousItems)}"
    End Function

    Public Function Recite(ByVal startVerse As Integer, ByVal endVerse As Integer) As String
        Return String.Join(
            Environment.NewLine,
            Enumerable.Range(startVerse, endVerse - startVerse + 1) _
                .Select(Function(verseNumber) Recite(verseNumber))
        )
    End Function
End Module