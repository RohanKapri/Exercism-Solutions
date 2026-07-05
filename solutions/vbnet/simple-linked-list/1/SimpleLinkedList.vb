Public Class SimpleLinkedList(Of T)
    Implements IEnumerable(Of T)

    Private Class Node
        Public Property Value As T
        Public Property NextNode As Node
        Public Sub New(ByVal value As T)
            Me.Value = value
        End Sub
    End Class

    Private _head As Node
    Private _current As Node
    Private _count As Integer

    Public Sub New()

        _head = Nothing
        _current = Nothing

    End Sub

    Public Sub New(ByVal value As T)

        _head = Nothing
        Push(value)

    End Sub

    Public Sub New(ByVal values As IEnumerable(Of T))

        _head = Nothing
        For Each v In values
            Push(v)
        Next

    End Sub

    Public Property Count As Integer

        Private Set(value As Integer)
            _count = value
        End Set
        Get
            Return _count
        End Get

    End Property

    Public Sub Push(ByVal value As T)

        Dim newNode As New Node(value) With {
            .Value = value
        }

        If _head Is Nothing Then
            _head = newNode
            newNode.NextNode = Nothing
        Else
            newNode.NextNode = _head
            _head = newNode
        End If

        _count += 1

    End Sub

    Public Function Pop() As T

        Dim value As T

        If _head IsNot Nothing Then
            value = _head.Value
            _head = _head.NextNode
            _count -= 1
            Return value
        End If

    End Function

    Public Sub Reset()

        _current = _head

    End Sub

    Public Function MoveNext() As Boolean

        _current = _current.NextNode

        If _current Is Nothing Then Return False
        Return True

    End Function

    Public Iterator Function GetEnumerator() As IEnumerator(Of T) Implements IEnumerable(Of T).GetEnumerator

        Dim myNode As Node = _head
        Dim value As T

        If myNode IsNot Nothing Then
            While (myNode IsNot Nothing)
                value = myNode.Value
                myNode = myNode.NextNode
                Yield value
            End While
        Else
            Yield Nothing
        End If

    End Function

    Private Function IEnumerable_GetEnumerator() As IEnumerator Implements IEnumerable.GetEnumerator

        Return Me.GetEnumerator()

    End Function

End Class
      
      