Imports System
Imports System.Collections.Generic

Public Class CircularBuffer(Of T)
    Inherits Queue(Of T)

    Public ReadOnly Property Capacity As Integer

    Public Sub New(ByVal capacity As Integer)
        Me.Capacity = capacity
    End Sub

    Public Function Read() As T
        If Count = 0 Then
            Throw New InvalidOperationException("buffer is empty.")
        End If
        Dim item = Dequeue()
        Return item
    End Function

    Public Sub Write(ByVal value As T)
        If Count = Capacity Then
            Throw New InvalidOperationException("buffer is full.")
        End If
        Enqueue(value)
    End Sub

    Public Sub Overwrite(ByVal value As T)
        If Count = Capacity Then
            Dequeue()
        End If
        Enqueue(value)
    End Sub
End Class