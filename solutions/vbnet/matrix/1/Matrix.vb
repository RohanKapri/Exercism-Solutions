Imports System.Linq

Public Class Matrix
    Private ReadOnly matrix As Integer()()

    Public Sub New(ByVal input As String)
        matrix = input.Split(vbLf) _
            .Select(Function(rowStr) rowStr.Split(" "c).Select(Function(num) Integer.Parse(num)).ToArray()) _
            .ToArray()
    End Sub

    Public Function Row(ByVal rowNum As Integer) As Integer()
        Return matrix(rowNum - 1)
    End Function

    Public Function Column(ByVal col As Integer) As Integer()
        Return matrix.Select(Function(row) row(col - 1)).ToArray()
    End Function
End Class