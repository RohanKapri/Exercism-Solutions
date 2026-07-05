Imports System.Collections.Generic
Imports System.Linq
Imports System.Text.RegularExpressions
Imports System.Runtime.CompilerServices

Public Module WordCount
    Public Function CountWords(ByVal phrase As String) As IDictionary(Of String, Integer)
        Return phrase.Words().GroupBy(Function(w) w.ToLowerInvariant()).ToDictionary(Function(g) g.Key, Function(g) g.Count())
    End Function

    <Extension()>
    Private Function Words(ByVal phrase As String) As IEnumerable(Of String)
        Return Regex.Matches(phrase, "\w+('\w+)*").[Select](Function(m) m.Value)
    End Function
End Module