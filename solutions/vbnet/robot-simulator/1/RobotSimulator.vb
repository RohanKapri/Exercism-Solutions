Imports System

Public Enum DirectionType
    North
    East
    South
    West
End Enum

Public Class RobotSimulator
    Private _direction As DirectionType
    Private _x As Integer
    Private _y As Integer

    Public Sub New(ByVal direction As DirectionType, ByVal x As Integer, ByVal y As Integer)
        _direction = direction
        _x = x
        _y = y
    End Sub

    Public ReadOnly Property Direction As DirectionType
        Get
            Return _direction
        End Get
    End Property

    Public ReadOnly Property X As Integer
        Get
            Return _x
        End Get
    End Property

    Public ReadOnly Property Y As Integer
        Get
            Return _y
        End Get
    End Property

    Public Sub Move(ByVal instructions As String)
        For Each s As Char In instructions
            If s = "R" Then
                _direction = If(_direction <> DirectionType.West, CType(_direction + 1, DirectionType), DirectionType.North)
            ElseIf s = "L" Then
                _direction = If(_direction <> DirectionType.North, CType(_direction - 1, DirectionType), DirectionType.West)
            ElseIf s = "A" Then
                If _direction = DirectionType.North OrElse _direction = DirectionType.South Then
                    _y += If(_direction = DirectionType.North, 1, -1)
                ElseIf _direction = DirectionType.East OrElse _direction = DirectionType.West Then
                    _x += If(_direction = DirectionType.East, 1, -1)
                End If
            End If
        Next
    End Sub
End Class