Imports System
Imports System.Collections.Generic

Public Class Robot
    Private _name As String
    Public ReadOnly Property Name As String
        Get
            If _name Is Nothing Then
                _name = RobotNameFactory.Create()
            End If
            Return _name
        End Get
    End Property

    Public Sub Reset()
        _name = Nothing
    End Sub
End Class

Friend Module RobotNameFactory
    Private rng As New Random()
    Private names As New HashSet(Of String)()

    Public Function Create() As String
        Dim name As String = $"{ChrW(rng.Next(CInt(AscW("A"c)), CInt(AscW("Z"c)) + 1))}{ChrW(rng.Next(CInt(AscW("A"c)), CInt(AscW("Z"c)) + 1))}{rng.Next(1000):D3}"
        If names.Add(name) Then
            Return name
        Else
            Return Create()
        End If
    End Function
End Module