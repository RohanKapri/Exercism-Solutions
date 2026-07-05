Imports System
Imports System.Diagnostics

Public Class Deque(Of T)
    Private Class Node(Of U)
        Public data As U
        Public [next] As Node(Of U)
        Public prev As Node(Of U)

        Public Sub New(ByVal t As U)
            Debug.Assert(t IsNot Nothing)
            data = t
            [next] = Nothing
            prev = Nothing
        End Sub
    End Class

    Private head As Node(Of T)
    Private tail As Node(Of T)

    Public Sub Push(ByVal value As T)
        Dim newNode = New Node(Of T)(value)

        If tail Is Nothing Then
            head = newNode
        Else
            newNode.prev = tail
            tail.[next] = newNode
        End If

        tail = newNode
    End Sub

    Public Sub Unshift(ByVal value As T)
        Dim newNode = New Node(Of T)(value)
        newNode.[next] = head

        If head Is Nothing Then
            tail = newNode
        Else
            head.prev = newNode
        End If

        head = newNode
    End Sub

    Public Function Pop() As T
        If tail IsNot Nothing Then
            Dim popped = tail
            tail = tail.prev

            If tail Is Nothing Then
                head = Nothing
            End If

            Return popped.data
        End If

        Return Nothing ' Return default value for T
    End Function

    Public Function Shift() As T
        If head IsNot Nothing Then
            Dim shifted = head
            head = head.[next]

            If head Is Nothing Then
                tail = Nothing
            End If

            Return shifted.data
        End If

        Return Nothing ' Return default value for T
    End Function
End Class