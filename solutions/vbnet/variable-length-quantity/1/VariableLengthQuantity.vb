Imports System
Imports System.Linq
Imports System.Collections.Generic

Public Module VariableLengthQuantity
    Public Function Encode(ByVal numbers As UInteger()) As UInteger()
        Return numbers.SelectMany(Function(n) Split(n).Reverse()).ToArray()
    End Function

    Public Function Decode(ByVal bytes As UInteger()) As UInteger()
        Return Join(bytes).ToArray()
    End Function

    Private Iterator Function Split(number As UInteger) As IEnumerable(Of UInteger)
        Yield number And &H7F
        number >>= 7
        While number <> 0
            Yield (number And &H7F) Or &H80
            number >>= 7
        End While
    End Function

    Private Iterator Function Join(bytes As UInteger()) As IEnumerable(Of UInteger)
        If (bytes.Last() And &H80) <> 0 Then
            Throw New InvalidOperationException()
        End If

        Dim temp = 0UI
        For Each n In bytes
            temp = (temp << 7) Or (n And &H7F)
            If (n And &H80) = 0 Then
                Yield temp
                temp = 0UI
            End If
        Next
    End Function
End Module