Imports System

Public Module BottleSong
    Public Function Recite(ByVal startBottles As Integer, ByVal takeDown As Integer) As String
        Dim result As New List(Of String)

        For i As Integer = startBottles To startBottles - takeDown + 1 Step -1
            Dim currentBottles As String = BottleText(i)
            Dim nextBottles As String = BottleText(i - 1).ToLower()
            
            result.Add($"{currentBottles} hanging on the wall,")
            result.Add($"{currentBottles} hanging on the wall,")
            result.Add("And if one green bottle should accidentally fall,")
            result.Add($"There'll be {nextBottles} hanging on the wall.")
            
            If i > startBottles - takeDown + 1 Then
                result.Add("") ' Add a blank line between verses
            End If
        Next
        
        Return String.Join(vbLf, result)
    End Function

    Private Function BottleText(ByVal count As Integer) As String
        Select Case count
            Case 10
                Return "Ten green bottles"
            Case 9
                Return "Nine green bottles"
            Case 8
                Return "Eight green bottles"
            Case 7
                Return "Seven green bottles"
            Case 6
                Return "Six green bottles"
            Case 5
                Return "Five green bottles"
            Case 4
                Return "Four green bottles"
            Case 3
                Return "Three green bottles"
            Case 2
                Return "Two green bottles"
            Case 1
                Return "One green bottle"
            Case Else
                Return "no green bottles"
        End Select
    End Function
End Module