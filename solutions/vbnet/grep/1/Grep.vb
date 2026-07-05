Imports System
Imports System.IO
Imports System.Linq
Imports System.Collections.Generic

Public Module Grep
    Public Function Match(ByVal pattern As String, ByVal flagsInput As String, ByVal files As String()) As String
        Dim Content = files.ToDictionary(Function(x) x, Function(x) File.ReadAllLines(x).[Select](Function(y, i) Tuple.Create(y, i + 1)))
        Dim Flags = flagsInput.Split(" "c).Where(Function(x) x.StartsWith("-")).ToArray()
        Dim IsCaseInsensitive = Flags.Any(Function(x) x = "-i")

        If IsCaseInsensitive Then
            pattern = pattern.ToUpper()
        End If

        Dim MatchEntireLines = Flags.Any(Function(x) x = "-x")
        Dim MatchFilter As Func(Of String, Boolean) = If(MatchEntireLines,
            Function(x) x = pattern,
            Function(x) x.Contains(pattern))

        Dim CaseInsensitiveFilter As Func(Of String, Boolean) = If(IsCaseInsensitive,
            Function(x) MatchFilter(x.ToUpper()),
            MatchFilter)

        Dim InvertMatches = Flags.Any(Function(x) x = "-v")
        Dim Filter As Func(Of String, Boolean) = If(InvertMatches,
            Function(x) Not CaseInsensitiveFilter(x),
            CaseInsensitiveFilter)

        Dim PrintFileNames = Flags.Any(Function(x) x = "-l")
        Dim PrintLineNumbers = Flags.Any(Function(x) x = "-n") AndAlso Not PrintFileNames

        Dim LineNumberProjection As Func(Of String, Integer, String) = If(PrintLineNumbers,
            Function(x, i) i & ":" & x,
            Function(x, i) x)

        Dim Projection As Func(Of Dictionary(Of String, IEnumerable(Of Tuple(Of String, Integer))), IEnumerable(Of String)) = If(PrintFileNames,
            Function(x) Content.Where(Function(y) y.Value.[Select](Function(z) z.Item1).Any(Filter)).[Select](Function(y) y.Key),
            Function(x) Content.[Select](Function(y) y.Value.Where(Function(z) Filter(z.Item1)).[Select](Function(z) If(x.Count > 1, y.Key & ":", "") & LineNumberProjection(z.Item1, z.Item2))).SelectMany(Function(y) y))

        Return String.Join(Environment.NewLine, Projection(Content))
    End Function
End Module