Public Module ReverseString
    Public Function Reverse(ByVal inputString As String) As String
        Return String.Join("", inputString.Reverse().ToArray())
    End Function
End Module