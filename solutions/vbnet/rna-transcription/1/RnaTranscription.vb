Imports System
Imports System.Collections.Generic
Imports System.Linq

Public Module RnaTranscription
    Private DnaToRna As Dictionary(Of Char, Char) = New Dictionary(Of Char, Char) From {
        {"A"c, "U"c},
        {"C"c, "G"c},
        {"G"c, "C"c},
        {"T"c, "A"c}
    }

    Public Function ToRna(ByVal nucleotide As String) As String
        Return String.Concat(nucleotide.[Select](Function(x) DnaToRna(x)))
    End Function
End Module


  