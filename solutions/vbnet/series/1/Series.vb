Imports System
Imports System.Linq

Public Module Series
    Public Function Slices(ByVal numbers As String, ByVal sliceLength As Integer) As String()
        Dim inLength As Integer = numbers.Length
        If sliceLength < 1 OrElse sliceLength > inLength OrElse inLength < 1 Then Throw New ArgumentException()
        Return (From i In Enumerable.Range(0, inLength - sliceLength + 1) Select numbers.Substring(i, sliceLength)).ToArray()
    End Function
End Module