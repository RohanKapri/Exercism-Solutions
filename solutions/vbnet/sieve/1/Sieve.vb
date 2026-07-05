Imports System

Public Module Sieve
  
    Public Function Primes(ByVal limit As Integer) As Integer()

        If limit <= 0 Then Throw New ArgumentOutOfRangeException

        If limit = 1 Then Return {}

        Dim primeNumbers As New List(Of Integer)

        For i = 2 To limit
            primeNumbers.Add(i)
        Next

        For i = 2 To limit
            If primeNumbers.Contains(i) Then
                For j = i * i To limit Step i
                    primeNumbers.Remove(j)
                Next
            End If
        Next

        Return primeNumbers.ToArray

    End Function

End Module