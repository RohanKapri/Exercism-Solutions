Public Module CollatzConjecture

    ''' <summary>
    ''' Returns the number of steps it takes in a Collatz conjecture ("<c>(even number / 2), ((odd number * 3) + 1)</c>")
    ''' to reach 1.
    ''' </summary>
    ''' <param name="number">The number to start with (a value greater than or equal to 1).</param>
    ''' <returns>The number of steps it takes to reach 1.</returns>
    ''' <exception cref="ArgumentOutOfRangeException">An ArgumentOutOfRangeException is thrown if <paramref name="number"/> is 0 or negative.</exception>
    Public Function Steps(ByVal number As Int32) As Int32
        If (number < 1) Then Throw New ArgumentOutOfRangeException(NameOf(number), number, $"The given number must be range of 1 to {NameOf(Int32)}.{NameOf(Int32.MaxValue)}!")
        Dim mySteps As Int32 = 0
        Dim myNumber As Int64 = number
        While (myNumber > 1)
            mySteps += 1
            If (IsOdd(myNumber)) Then
                myNumber = (myNumber * 3) + 1
            Else
                myNumber \= 2L
            End If
        End While
        Return mySteps
    End Function

    'Private Methods

    Private Function IsOdd(value As Int64) As Boolean
        Return ((value Mod 2L) = 1L)
    End Function

End Module