Imports System

Public Module Grains
    Public Function Square(ByVal n As Integer) As ULong
        If n <= 0 Then
            Throw New ArgumentOutOfRangeException()
        End If
        If n > 64 Then
            Throw New ArgumentOutOfRangeException()
        End If
        Return 1UL << (n - 1)
    End Function
    
    Public Function Total() As ULong
        Return ULong.MaxValue
    End Function
End Module