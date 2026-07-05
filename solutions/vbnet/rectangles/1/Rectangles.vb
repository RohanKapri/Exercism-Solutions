Imports System

Public Module Rectangles
    Public Function Count(ByVal rows As String()) As Integer
        If rows Is Nothing OrElse rows.Length = 1 OrElse rows.Length = 0 Then Return 0
        Dim strLen As Integer = rows(0).Length
        Dim recCount As Integer = 0

        For i As Integer = 0 To rows.Length - 1 - 1
            For k As Integer = 0 To strLen - 1 - 1
                If rows(i)(k) = "+"c Then
                    For m As Integer = k + 1 To strLen - 1
                        If rows(i)(m) = "+"c Then
                            Dim isContinue1 As Boolean = True

                            For x As Integer = k + 1 To m - 1
                                If rows(i)(x) = " "c OrElse rows(i)(x) = "|"c Then isContinue1 = False
                            Next

                            If Not isContinue1 Then Exit For

                            For j As Integer = i + 1 To rows.Length - 1
                                If rows(j)(k) = " "c OrElse rows(j)(k) = "-"c OrElse rows(j)(m) = " "c OrElse rows(j)(m) = "-"c Then Exit For

                                If rows(j)(k) = "+"c AndAlso rows(j)(m) = "+"c Then
                                    Dim isContinue2 As Boolean = True

                                    For x As Integer = k + 1 To m - 1
                                        If rows(j)(x) = " "c OrElse rows(j)(x) = "|"c Then isContinue2 = False
                                    Next

                                    If Not isContinue2 Then Exit For
                                    recCount += 1
                                End If
                            Next
                        End If
                    Next
                End If
            Next
        Next

        Return recCount
    End Function
End Module