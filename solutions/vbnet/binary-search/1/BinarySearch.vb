Imports System

Public Module BinarySearch
    Private Function SearchBinary(ByVal value As Integer, ByVal array As Integer(), ByVal low As Integer, ByVal high As Integer) As Integer
        If low > high Then
            Return -1
        End If
        
        Dim mid As Integer = low + (high - low) \ 2
        Dim midValue As Integer = array(mid)
        
        If midValue = value Then
            Return mid
        ElseIf midValue < value Then
            Return SearchBinary(value, array, mid + 1, high)
        Else
            Return SearchBinary(value, array, low, mid - 1)
        End If
    End Function
    
    Public Function Find(ByVal input As Integer(), ByVal value As Integer) As Integer
        If input.Length < 1 Then
            Return -1
        Else
            Return SearchBinary(value, input, 0, input.Length - 1)
        End If
    End Function
End Module