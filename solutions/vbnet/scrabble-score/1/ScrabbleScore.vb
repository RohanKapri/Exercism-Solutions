Imports System

Public Module ScrabbleScore
    Public Function Score(ByVal input As String) As Integer
        If String.IsNullOrWhiteSpace(input) = True Then Return 0
        Dim totalScore As Integer = 0

        For Each character In input.ToUpper()

            Select Case character
                Case "A"c, "E"c, "I"c, "O"c, "U"c, "L"c, "N"c, "R"c, "S"c, "T"c
                    totalScore += 1
                Case "D"c, "G"c
                    totalScore += 2
                Case "B"c, "C"c, "M"c, "P"c
                    totalScore += 3
                Case "F"c, "H"c, "V"c, "W"c, "Y"c
                    totalScore += 4
                Case "K"c
                    totalScore += 5
                Case "J"c, "X"c
                    totalScore += 8
                Case "Q"c, "Z"c
                    totalScore += 10
                Case Else
                    Throw New ArgumentException($"Invalid Character {character}.", "input")
            End Select
        Next

        Return totalScore
    End Function
End Module