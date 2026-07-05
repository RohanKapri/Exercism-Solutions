Public Module TwoFer
    Public Function Speak(Optional Name as String = "you") As String
        Console.WriteLine("name = " + Name)
        Return "One for " + Name + ", one for me."
    End Function
End Module