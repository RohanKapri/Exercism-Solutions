Imports System

Public Class SpiralMatrix
    ReadOnly Shared directions = {
        (0, 1),
        (1, 0),
        (0, -1),
        (-1, 0)
    }
  
    Public Shared Function GetMatrix(ByVal size As Integer) As Integer(,)
        If size = 0 Then
            Return {{}}
        End If
        If size = 1 Then
            Return {{1}}
        End If

        Dim hmin = 0
        Dim hmax = size - 1
        Dim vmin = 0
        Dim vmax = size - 1
        Dim matrix(size-1, size-1) As Integer
        Dim currentPosition = (0, 0)
        Dim currentNumber = 1
        Dim currentDirection = 0

        While hmin <= hmax Or vmin <= vmax
            matrix(currentPosition.Item1, currentPosition.Item2) = currentNumber
            currentNumber += 1

            currentPosition = AddPoints(currentPosition, directions(currentDirection))

            If currentDirection = 0 And currentPosition.Item2 >= hmax Then
                vmin += 1
                currentDirection = NextDirectionIndex(currentDirection)
            ElseIf currentDirection = 1 And currentPosition.Item1 >= vmax Then
                hmax -= 1
                currentDirection = NextDirectionIndex(currentDirection)
            ElseIf currentDirection = 2 And currentPosition.Item2 <= hmin Then
                vmax -= 1
                currentDirection = NextDirectionIndex(currentDirection)
            ElseIf currentDirection = 3 And currentPosition.Item1 <= vmin Then
                hmin += 1
                currentDirection = NextDirectionIndex(currentDirection)
            End If
        End While

        Return matrix
    End Function

    Public Shared Function AddPoints(ByVal p1 As (Integer, Integer), ByVal p2 As (Integer, Integer)) As (Integer, Integer)
        Return (p1.Item1 + p2.Item1, p1.Item2 + p2.Item2)
    End Function

    Public Shared Function NextDirectionIndex(ByVal currentDirectionIndex As Integer) As Integer
        Return (currentDirectionIndex + 1) Mod 4
    End Function
End Class