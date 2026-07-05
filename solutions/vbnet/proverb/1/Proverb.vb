Imports System.Linq

Public Module Proverb
    Public Function Recite(ByVal subjects As String()) As String()
        If subjects.Length = 0 Then
            Return New String(-1) {}
        End If

        Return subjects.Zip(subjects.Skip(1), Function(a, b) $"For want of a {a} the {b} was lost.").Append($"And all for the want of a {subjects(0)}.").ToArray()
    End Function
End Module