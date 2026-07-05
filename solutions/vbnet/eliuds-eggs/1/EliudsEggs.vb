Imports System

Public Module EliudsEggs
    Public Function EggCount(n As Integer) As Integer
        Dim nEggs = 0
        Dim mask = 1
        For i = 1 To 8*Len(n)
            If (n And mask) = mask Then
                nEggs += 1
            End If

            mask <<= 1
        Next

        Return nEggs
    End Function
End Module