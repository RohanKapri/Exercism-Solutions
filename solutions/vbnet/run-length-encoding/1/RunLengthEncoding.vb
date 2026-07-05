Imports System
Imports System.Text.RegularExpressions

Public Module RunLengthEncoding
    Public Function Encode(ByVal input As String) As String
        Return Regex.Replace(input, "(\D)\1+", Function(m) m.Length.ToString() & m.Value(0))
    End Function

    Public Function Decode(ByVal input As String) As String
        Return Regex.Replace(input, "(\d+)(\D)", Function(m) New String(m.Groups(2).Value(0), Int32.Parse(m.Groups(1).Value)))
    End Function
End Module