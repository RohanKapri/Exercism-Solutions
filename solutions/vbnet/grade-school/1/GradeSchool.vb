Imports System
Imports System.Collections.Generic
Imports System.Linq

Public Class GradeSchool
    Private ReadOnly _roster As New Dictionary(Of String, Integer)()

    Public Function Add(ByVal student As String, ByVal grade As Integer) As Boolean
        If Not _roster.ContainsKey(student) Then
            _roster.Add(student, grade)
            Return True
        Else
            Return False
        End If
    End Function

    Public Function Roster() As IEnumerable(Of String)
        Return _roster.OrderBy(Function(x) x.Value).ThenBy(Function(x) x.Key).Select(Function(x) x.Key)
    End Function

    Public Function Grade(ByVal requestedGrade As Integer) As IEnumerable(Of String)
        Return _roster.Where(Function(x) x.Value = requestedGrade).OrderBy(Function(x) x.Key).Select(Function(x) x.Key).ToArray()
    End Function
End Class