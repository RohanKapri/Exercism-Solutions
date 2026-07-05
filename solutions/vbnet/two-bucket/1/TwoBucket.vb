Imports System
Imports System.Collections.Generic
Imports System.Linq

Public Enum Bucket
    One
    Two
End Enum

Public Class TwoBucketResult
    Public Property Moves As Integer
    Public Property GoalBucket As Bucket
    Public Property OtherBucket As Integer
End Class

Public Class TwoBucket
    Private ReadOnly _sizes As Integer()
    Private ReadOnly _startBucket As Integer

    Public Sub New(bucketOne As Integer, bucketTwo As Integer, startBucket As Bucket)
        _sizes = New Integer() {bucketOne, bucketTwo}
        _startBucket = CInt(startBucket)
    End Sub

    Private Shared Function Empty(buckets As IReadOnlyList(Of Integer), i As Integer) As Integer()
        If i = 0 Then
            Return New Integer() {0, buckets(1)}
        Else
            Return New Integer() {buckets(0), 0}
        End If
    End Function

    Private Function Fill(buckets As IReadOnlyList(Of Integer), i As Integer) As Integer()
        If i = 0 Then
            Return New Integer() {_sizes(0), buckets(1)}
        Else
            Return New Integer() {buckets(0), _sizes(1)}
        End If
    End Function

    Private Function Consolidate(buckets As IReadOnlyList(Of Integer), i As Integer) As Integer()
        Dim amount = {buckets(1 - i), _sizes(i) - buckets(i)}.Min()
        Dim target = buckets(i) + amount
        Dim src = buckets(1 - i) - amount
        If i = 0 Then
            Return New Integer() {target, src}
        Else
            Return New Integer() {src, target}
        End If
    End Function

    Public Function Measure(goal As Integer) As TwoBucketResult
        Dim invalid = {0, 0}
        invalid(1 - _startBucket) = _sizes(1 - _startBucket)
        Dim invalidStr = String.Join(",", invalid)
        Dim buckets = {0, 0}
        buckets(_startBucket) = _sizes(_startBucket)
        Dim toVisit As New Queue(Of (Integer(), Integer))()
        Dim visited As New HashSet(Of String)()
        Dim count = 1
        Dim goalBucket = Array.IndexOf(buckets, goal)
        While goalBucket < 0
            Dim key = String.Join(",", buckets)
            If Not visited.Contains(key) AndAlso Not key.Equals(invalidStr) Then
                visited.Add(key)
                Dim nc = count + 1
                For i = 0 To 1
                    If buckets(i) <> 0 Then
                        toVisit.Enqueue((Empty(buckets, i), nc))
                    End If
                    If buckets(i) <> _sizes(i) Then
                        toVisit.Enqueue((Fill(buckets, i), nc))
                        toVisit.Enqueue((Consolidate(buckets, i), nc))
                    End If
                Next
            End If
            If Not toVisit.Any() Then
                Throw New ArgumentException("no more moves!")
            End If
            Dim pair = toVisit.Dequeue()
            buckets = pair.Item1
            count = pair.Item2
            goalBucket = Array.IndexOf(buckets, goal)
        End While
        Return New TwoBucketResult With {
            .Moves = count,
            .GoalBucket = DirectCast(goalBucket, Bucket),
            .OtherBucket = buckets(1 - goalBucket)
        }
    End Function
End Class