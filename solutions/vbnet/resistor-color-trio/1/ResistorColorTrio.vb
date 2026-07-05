Public Module ResistorColorTrio

    Private ReadOnly dict As New Dictionary(Of String, Integer) From {
            {"BLACK", 0},
            {"BROWN", 1},
            {"RED", 2},
            {"ORANGE", 3},
            {"YELLOW", 4},
            {"GREEN", 5},
            {"BLUE", 6},
            {"VIOLET", 7},
            {"GREY", 8},
            {"WHITE", 9}}

    Public Function Label(ByVal colors As String()) As String

        Dim n1 = dict.Item(colors(0).ToUpper)
        Dim n2 = dict.Item(colors(1).ToUpper)
        Dim n3 = dict.Item(colors(2).ToUpper)

        Dim value As Long = (n1 * 10 + n2) * CLng(Math.Pow(10, n3))

        Select Case value
            Case < 1000
                Return $"{value} ohms"
            Case < 1000000
                Return $"{value \ 1000} kiloohms"
            Case < 1000000000
                Return $"{value \ 1000000} megaohms"
            Case Else
                Return $"{value \ 1000000000} gigaohms"
        End Select

    End Function

End Module