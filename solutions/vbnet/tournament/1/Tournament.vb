Imports System
Imports System.Collections.Generic
Imports System.IO
Imports System.Linq

Public Module Tournament
    Public Sub Tally(ByVal inStream As Stream, ByVal outStream As Stream)
        Dim matches As New List(Of (teamA As String, teamB As String, result As String))()
        Using reader As New StreamReader(inStream)
            While True
                Dim line As String = reader.ReadLine()
                If line Is Nothing Then
                    Exit While
                End If
                Dim parts As String() = line.Split(";"c)
                matches.Add((parts(0), parts(1), parts(2)))
            End While
        End Using
        Using writer As New StreamWriter(outStream)
            writer.Write("Team                           | MP |  W |  D |  L |  P")
            Dim results = matches.SelectMany(Function(m)
                If m.result = "draw" Then
                    Return New (team As String, result As Char, points As Integer)() {
                        (team:=m.teamA, result:="D"c, points:=1),
                        (team:=m.teamB, result:="D"c, points:=1)
                    }
                End If
                Return New (team As String, result As Char, points As Integer)() {
                    (team:=If(m.result = "win", m.teamA, m.teamB), result:="W"c, points:=3),
                    (team:=If(m.result = "win", m.teamB, m.teamA), result:="L"c, points:=0)
                }
            End Function)
            Dim table = results.GroupBy(Function(r) r.team).Select(Function(g) New With {
                .Name = g.Key,
                .MP = g.Count(),
                .W = g.Count(Function(x) x.result = "W"c),
                .D = g.Count(Function(x) x.result = "D"c),
                .L = g.Count(Function(x) x.result = "L"c),
                .P = g.Sum(Function(x) x.points)
            }).OrderByDescending(Function(r) r.P).ThenBy(Function(r) r.Name)
            For Each r In table
                writer.Write(vbLf & $"{r.Name,-30} | {r.MP,2} | {r.W,2} | {r.D,2} | {r.L,2} | {r.P,2}")
            Next
        End Using
    End Sub
End Module