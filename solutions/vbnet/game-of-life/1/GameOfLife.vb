Imports System
Imports System.Collections.Generic
Imports System.Linq

Public Class GameOfLife

    Private ReadOnly cellDictionary As Dictionary(Of (xPos As Integer, yPos As Integer), Boolean)
    Private ReadOnly maxX As Integer
    Private ReadOnly maxY As Integer

    Public Sub New(ByVal matrix As List(Of List(Of Integer)))

        cellDictionary = New Dictionary(Of (Integer, Integer), Boolean)
        maxX = matrix.Count - 1
        maxY = If(matrix.Count > 0, matrix.First().Count - 1, 0)

        For x = 0 To maxX

            For y = 0 To maxY

                cellDictionary((x, y)) = matrix(x)(y) <> 0

            Next

        Next

    End Sub

    Public Sub Tick()

        Dim nextState = New Dictionary(Of (Integer, Integer), Boolean)(cellDictionary)

        For x = 0 To maxX

            For y = 0 To maxY

                Dim aliveNeighbors = CountAliveNeighbors(x, y)
                Dim isAlive = cellDictionary((x, y))

                If isAlive Then

                    nextState((x, y)) = (aliveNeighbors = 2 OrElse aliveNeighbors = 3)

                Else

                    nextState((x, y)) = (aliveNeighbors = 3)

                End If

            Next

        Next

        cellDictionary.Clear()

        For Each kvp In nextState

            cellDictionary(kvp.Key) = kvp.Value

        Next

    End Sub

    Public Function Matrix() As List(Of List(Of Integer))

        Dim result = New List(Of List(Of Integer))

        For x = 0 To maxX

            Dim row = New List(Of Integer)

            For y = 0 To maxY

                row.Add(If(cellDictionary((x, y)), 1, 0))

            Next

            result.Add(row)

        Next

        Return result

    End Function

    Private Function CountAliveNeighbors(xPos As Integer, yPos As Integer) As Integer

        Dim count As Integer = 0

        For x = -1 To 1

            For y = -1 To 1

                If x = 0 AndAlso y = 0 Then Continue For

                Dim key = (x + xPos, y + yPos)

                If cellDictionary.ContainsKey(key) AndAlso cellDictionary(key) Then

                    count += 1

                End If

            Next

        Next

        Return count

    End Function

End Class