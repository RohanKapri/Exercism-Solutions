Imports System
Imports System.Collections.Generic

Public Module PrimeFactors
    Public Function Factors(ByVal number As Long) As Long()
        Dim longArr As List(Of Long) = New List(Of Long)()

        While number Mod 2L = 0
            longArr.Add(2L)
            number = number / 2L
        End While

        Dim i As Long = 3

        While i <= number * 2

            While number Mod i = 0
                longArr.Add(i)
                number = number / i
            End While

            i = i + 2
        End While

        If number > 2 Then longArr.Add(number)
        Return longArr.ToArray()
    End Function
End Module