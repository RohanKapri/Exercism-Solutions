Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Linq

Module ProteinTranslation
    Function Proteins(ByVal codon As String) As String()
        Dim dict = New Dictionary(Of String, String)() From {
            {"AUG", "Methionine"},
            {"UUU", "Phenylalanine"},
            {"UUC", "Phenylalanine"},
            {"UUA", "Leucine"},
            {"UUG", "Leucine"},
            {"UCU", "Serine"},
            {"UCC", "Serine"},
            {"UCA", "Serine"},
            {"UCG", "Serine"},
            {"UAU", "Tyrosine"},
            {"UAC", "Tyrosine"},
            {"UGU", "Cysteine"},
            {"UGC", "Cysteine"},
            {"UGG", "Tryptophan"},
            {"UAA", "STOP"},
            {"UAG", "STOP"},
            {"UGA", "STOP"}
        }
    
        Return Enumerable.Range(0, codon.Length / 3).[Select](Function(i) codon.Substring(i * 3, 3)).[Select](Function(c) dict(c)).TakeWhile(Function(c) c <> "STOP").ToArray()
    End Function
End Module