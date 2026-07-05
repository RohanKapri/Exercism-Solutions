Imports System
Imports System.Collections.Generic
Imports System.Linq

Public Structure TreeBuildingRecord
    Public Property ParentId As Integer
    Public Property RecordId As Integer
End Structure

Public Structure Tree
    Public Property Id As Integer
    Public Property ParentId As Integer
    Public Property Children As List(Of Tree)
    Public ReadOnly Property IsLeaf As Boolean
        Get
            Return Children.Count = 0
        End Get
    End Property

    Public Shared Function Create(record As TreeBuildingRecord) As Tree
        Return New Tree With {.Children = New List(Of Tree)(), .Id = record.RecordId, .ParentId = record.ParentId}
    End Function

    Public Shared Function IsInvalid(t As Tree, previousRecordId As Integer) As Boolean
        Return t.ParentId >= t.Id OrElse t.Id <> previousRecordId + 1
    End Function
End Structure

Public Module TreeBuilder
    Public Function BuildTree(records As IEnumerable(Of TreeBuildingRecord)) As Tree
        Dim trees = records.OrderBy(Function(record) record.RecordId).Select(AddressOf Tree.Create).ToArray()

        If trees.Length = 0 OrElse trees(0).Id <> 0 OrElse trees(0).ParentId <> 0 OrElse trees.Skip(1).Where(Function(t) Tree.IsInvalid(t, trees(Array.IndexOf(trees, t) - 1).Id)).Any() Then
            Throw New ArgumentException()
        End If

        Return trees.Skip(1).Aggregate(trees, Function(ts, t) 
                                                    ts(t.ParentId).Children.Add(t)
                                                    Return ts
                                                End Function)(0)
    End Function
End Module