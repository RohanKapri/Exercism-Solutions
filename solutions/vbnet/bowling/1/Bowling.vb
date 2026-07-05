Imports System

Friend Structure TwoQueue(Of T)
    Private ReadOnly _first As T
    Private ReadOnly _second As T
    Public ReadOnly Property Length As Integer
    Public Sub New(ByVal first As T)
        Me.New(first, Nothing, 1)
    End Sub
    Public Sub New(ByVal first As T, ByVal second As T)
        Me.New(first, second, 2)
    End Sub
    Private Sub New(ByVal first As T, ByVal second As T, ByVal length As Integer)
        _first = first
        _second = second
        Me.Length = length
    End Sub
    Public Function Enqueue(ByVal x As T) As TwoQueue(Of T)
        If Length = 0 Then
            Return New TwoQueue(Of T)(x)
        Else
            Return New TwoQueue(Of T)(_first, x)
        End If
    End Function
    Default Public ReadOnly Property Item(ByVal index As Integer) As T
        Get
            If index = 0 Then
                Return _first
            Else
                Return _second
            End If
        End Get
    End Property
End Structure

Public Class BowlingGame
    Private _queue As TwoQueue(Of Integer)
    Private _score As Integer
    Private _frame As Integer

    Private Function IsStrike(ByVal i As Integer) As Boolean
        Return _queue(i) = 10
    End Function

    Private ReadOnly Property IsClosedFrame As Boolean
        Get
            Return _queue.Length = 2
        End Get
    End Property

    Private Function TooManyPins(ByVal i As Integer, ByVal pins As Integer) As Boolean
        Return _queue.Length = i + 1 AndAlso Not IsStrike(i) AndAlso _queue(i) + pins > 10
    End Function

    Private Function Validate(ByVal pins As Integer) As Integer
        If _frame = 10 OrElse pins < 0 OrElse pins > 10 OrElse TooManyPins(0, pins) OrElse IsStrike(0) AndAlso TooManyPins(1, pins) Then
            Throw New ArgumentException()
        Else
            Return pins
        End If
    End Function

    Private Function CanScoreFrame(ByVal pins As Integer) As Boolean
        Return IsClosedFrame OrElse (_queue.Length = 1 AndAlso _queue(0) + pins < 10)
    End Function

    Private Function UpdateQueue(ByVal pins As Integer) As TwoQueue(Of Integer)
        If IsStrike(0) Then
            Return New TwoQueue(Of Integer)(_queue(1), pins)
        ElseIf IsClosedFrame Then
            Return New TwoQueue(Of Integer)(pins)
        Else
            Return New TwoQueue(Of Integer)()
        End If
    End Function

    Public Sub Roll(ByVal pins As Integer)
        Dim newQueue As TwoQueue(Of Integer)
        Dim newScore As Integer
        Dim newFrame As Integer
        If CanScoreFrame(Validate(pins)) Then
            newQueue = UpdateQueue(pins)
            newScore = _score + _queue(0) + _queue(1) + pins
            newFrame = _frame + 1
        Else
            newQueue = _queue.Enqueue(pins)
            newScore = _score
            newFrame = _frame
        End If
        _queue = newQueue
        _score = newScore
        _frame = newFrame
    End Sub

    Public Function Score() As Integer
        If _frame = 10 Then
            Return _score
        Else
            Throw New ArgumentException()
        End If
    End Function
End Class