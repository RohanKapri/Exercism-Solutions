Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Text

Public Class RailFenceCipher
    Private ReadOnly _rails As Integer

    Public Sub New(rails As Integer)
        _rails = rails - 1
    End Sub

    Private Function GetRow(i As Integer) As Integer
        Return _rails - Math.Abs(i Mod (2 * _rails) - _rails)
    End Function

    Private Iterator Function ZigZagIndex(Of T)(seq As IEnumerable(Of T)) As IEnumerable(Of T)
        Dim indexedSeq = seq.Select(Function(c, i) (c, i)).ToList()
        Dim grouped = indexedSeq.GroupBy(Function(v) GetRow(v.i))
        For Each group In grouped
            For Each c In group.OrderBy(Function(v) v.i)
                Yield c.c
            Next
        Next
    End Function

    Public Function Encode(input As String) As String
        Return String.Join("", ZigZagIndex(input))
    End Function

    Public Function Decode(input As String) As String
        Dim zigZagged = ZigZagIndex(Enumerable.Range(0, input.Length)).ToList()
        Dim zipped = zigZagged.Zip(input, Function(f, s) (i:=f, c:=s))
        Dim ordered = zipped.OrderBy(Function(v) v.i)
        Dim resultBuilder As New StringBuilder()
        For Each v In ordered
            resultBuilder.Append(v.c)
        Next
        Return resultBuilder.ToString()
    End Function
End Class