Imports System.Text.RegularExpressions

Public Module PigLatin
    Public Function Translate(ByVal word As String) As String
        Return Regex.Replace(word, "\b(ch?|qu?|squ|thr|th|sch|y(?!t)|x(?!r)|[bdfghjklmnprstvwz]{2,}(?=y)|[bdfghjklmnprstvwz])?(\S+)", "$2$1ay", RegexOptions.IgnoreCase)
    End Function
End Module