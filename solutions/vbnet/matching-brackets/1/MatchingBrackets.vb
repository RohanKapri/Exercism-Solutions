Imports System.Collections.Generic
Imports System.Linq

Public Module MatchingBrackets
    Private ReadOnly Brackets As String() = {"()", "[]", "{}"}

    Public Function IsPaired(ByVal input As String) As Boolean
        Dim sequence = From c In input Let pair = Brackets.FirstOrDefault(Function(p) p.Contains(c)) Where Not Equals(pair, Nothing) Let close = pair(1) = c Select (c, pair, close)
        Dim stack = New Stack(Of String)()
        Dim popped As String = Nothing

        For Each cPairClose In sequence
            Dim c = cPairClose.Item1
            Dim pair = cPairClose.Item2
            Dim close = cPairClose.Item3

            If close Then
                If Not stack.TryPop(popped) OrElse popped(1) <> c Then Return False
            Else
                stack.Push(pair)
            End If
        Next

        Return stack.Count = 0
    End Function
End Module