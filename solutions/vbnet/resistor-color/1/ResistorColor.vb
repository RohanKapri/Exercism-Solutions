Module Program
    Function ColorCode(ByVal color As String) As Integer
        Return Array.IndexOf(Colors(), color)
    End Function

    Function Colors() As String()
        Return {"black", "brown", "red", "orange", "yellow", _
                "green", "blue", "violet", "grey", "white"}
    End Function
End Module