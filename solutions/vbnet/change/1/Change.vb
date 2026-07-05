Imports System
Imports System.Collections.Generic

Public Module Change
    Public Function FindFewestCoins(ByVal coins As Integer(), ByVal target As Integer) As Integer()
        If target < 0 Then
            Throw New ArgumentException()
        End If
        If target = 0 Then
            Return New Integer() {}
        End If

        Dim FewestCoins As New Dictionary(Of Integer, Integer)()
        For Each coin As Integer In coins
            FewestCoins.Add(coin, 0)
        Next

        While True
            Dim changed As Boolean = False
            Dim buffer As Integer() = New Integer(FewestCoins.Count - 1) {}
            FewestCoins.Keys.CopyTo(buffer, 0)

            For Each coin As Integer In coins
                For Each fckey As Integer In buffer
                    Dim newValue As Integer = fckey + coin
                    If Not FewestCoins.ContainsKey(newValue) AndAlso newValue <= target Then
                        FewestCoins.Add(newValue, fckey)
                        changed = True
                    End If
                    If newValue = target Then
                        GoTo Found
                    End If
                Next
            Next

            If Not changed Then
                Exit While
            End If
        End While

Found:
        Dim changes As New List(Of Integer)()
        If FewestCoins.ContainsKey(target) Then
            Dim current As Integer = target
            Do
                Dim parent As Integer = FewestCoins(current)
                changes.Add(current - parent)
                current = parent
            Loop While current > 0
            changes.Sort()
            Return changes.ToArray()
        End If

        Throw New ArgumentException()
    End Function
End Module