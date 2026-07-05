Imports System

Public Module NthPrime
  
    Public Function Prime(ByVal number As Integer) As Integer

        If number < 1 Then Throw New ArgumentOutOfRangeException

        Dim isprime = Function(n As Integer) As Boolean
                          If n < 2 Then Return False
                          If n = 2 Then Return True
                          If n Mod 2 = 0 Then Return False

                          Dim limite As Integer = CInt(Math.Sqrt(n))
                          For i As Integer = 3 To limite Step 2
                              If n Mod i = 0 Then Return False
                          Next
                          Return True
                      End Function

        Dim count As Integer = 0
        Dim num As Integer = 1

        While count < number
            num += 1
            If isprime(num) Then
                count += 1
            End If
        End While

        Return num

    End Function

End Module