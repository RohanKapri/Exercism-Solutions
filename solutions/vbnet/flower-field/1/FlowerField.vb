Imports System

Public Module FlowerField

  Public Function Annotate(ByVal garden As String()) As String()

    If garden.Length = 0 Then Return garden

    Dim rows As Integer = garden.Length
    Dim cols As Integer = garden(0).Length
    Dim result(rows - 1) As String

    Dim directions = {
        (-1, -1), (-1, 0), (-1, 1),
        (0, -1),           (0, 1),
        (1, -1),  (1, 0),  (1, 1)
    }

    For r = 0 To rows - 1
        Dim chars = garden(r).ToCharArray()

        For c = 0 To cols - 1

            If garden(r)(c) = "*"c Then
                chars(c) = "*"c
            Else
                Dim count As Integer = 0

                For Each d In directions
                    Dim nr = r + d.Item1
                    Dim nc = c + d.Item2

                    If nr >= 0 AndAlso nr < rows AndAlso nc >= 0 AndAlso nc < cols Then
                        If garden(nr)(nc) = "*"c Then count += 1
                    End If
                Next

                If count > 0 Then
                    chars(c) = count.ToString()(0)
                Else
                    chars(c) = " "c
                End If
            End If

        Next

        result(r) = New String(chars)
    Next

    Return result

End Function

End Module