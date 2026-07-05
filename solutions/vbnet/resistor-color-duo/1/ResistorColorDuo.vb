Imports System

Public Module ResistorColorDuo
    Public Function Value(ByVal colors As String()) As Integer
        Dim colorList As String() = New String() {"black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"}
        Return Integer.Parse(Array.IndexOf(colorList, colors(0)).ToString() & Array.IndexOf(colorList, colors(1)).ToString())
    End Function
End Module