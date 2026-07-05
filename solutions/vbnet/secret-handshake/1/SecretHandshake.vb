Imports System
Imports System.Collections.Generic

Public Module SecretHandshake
    Private ReadOnly orders As IDictionary(Of Integer, String) = New Dictionary(Of Integer, String) From {
        {&B1, "wink"},
        {&B10, "double blink"},
        {&B100, "close your eyes"},
        {&B1000, "jump"}
    }

    Public Function Commands(ByVal commandValue As Integer) As String()
        Dim s = New List(Of String)()

        For Each order In orders
            If (commandValue And order.Key) = order.Key Then s.Add(order.Value)
        Next

        If (commandValue And &B10000) = &B10000 Then s.Reverse()
        Return s.ToArray()
    End Function
End Module