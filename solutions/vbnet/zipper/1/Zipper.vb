Imports System
Imports System.Collections.Generic
Imports System.Linq

Public Class BinTree
    Public Sub New(ByVal value As Integer, ByVal left As BinTree, ByVal right As BinTree)
        Me.Value = value
        Me.Left = left
        Me.Right = right
    End Sub

    Public ReadOnly Property Value As Integer
    Public ReadOnly Property Left As BinTree
    Public ReadOnly Property Right As BinTree

    Public Overrides Function Equals(ByVal obj As Object) As Boolean
        Dim that = TryCast(obj, BinTree)
        If that Is Nothing OrElse that.Value <> Value Then
            Return False
        End If
        Dim leftMatch = (that.Left Is Nothing AndAlso Left Is Nothing) OrElse (Left IsNot Nothing AndAlso Left.Equals(that.Left))
        Dim rightMatch = (that.Right Is Nothing AndAlso Right Is Nothing) OrElse (Right IsNot Nothing AndAlso Right.Equals(that.Right))
        Return leftMatch AndAlso rightMatch
    End Function

    Public Overrides Function GetHashCode() As Integer
        Return MyBase.GetHashCode()
    End Function
End Class

Public Class Zipper
    Private focus As BinTree
    Private parents As IEnumerable(Of (node As BinTree, isLeft As Boolean))

    Public Function Value() As Integer
        Return focus.Value
    End Function

    Public Function Left() As Zipper
        If focus.Left IsNot Nothing Then
            Return FromTree(focus.Left, parents.Prepend((focus, True)))
        Else
            Return Nothing
        End If
    End Function

    Public Function Right() As Zipper
        If focus.Right IsNot Nothing Then
            Return FromTree(focus.Right, parents.Prepend((focus, False)))
        Else
            Return Nothing
        End If
    End Function

    Public Function Up() As Zipper
        If Not parents.Any() Then
            Return Nothing
        End If
        Dim parent = parents.First()
        Dim others = parents.Skip(1)
        Dim newFocus = New BinTree(parent.node.Value,
            If(parent.isLeft, focus, parent.node.Left),
            If(parent.isLeft, parent.node.Right, focus))
        Return FromTree(newFocus, others)
    End Function

    Public Function SetValue(ByVal newValue As Integer) As Zipper
        Return FromTree(New BinTree(newValue, focus.Left, focus.Right), parents)
    End Function

    Public Function SetLeft(ByVal binTree As BinTree) As Zipper
        Return FromTree(New BinTree(focus.Value, binTree, focus.Right), parents)
    End Function

    Public Function SetRight(ByVal binTree As BinTree) As Zipper
        Return FromTree(New BinTree(focus.Value, focus.Left, binTree), parents)
    End Function

    Public Function ToTree() As BinTree
        Dim top = Me
        Dim [next] As Zipper = Nothing
        While (InlineAssignHelper([next], top.Up())) IsNot Nothing
            top = [next]
        End While
        Return top.focus
    End Function

    Public Shared Function FromTree(ByVal tree As BinTree, Optional ByVal parents As IEnumerable(Of (node As BinTree, isLeft As Boolean)) = Nothing) As Zipper
        Return New Zipper With {
            .focus = tree,
            .parents = If(parents IsNot Nothing, parents, Enumerable.Empty(Of (BinTree, Boolean))())
        }
    End Function

    Public Overrides Function Equals(ByVal obj As Object) As Boolean
        Return DirectCast(obj, Zipper).focus.Equals(focus)
    End Function

    Public Overrides Function GetHashCode() As Integer
        Return MyBase.GetHashCode()
    End Function

    Private Shared Function InlineAssignHelper(Of T)(ByRef target As T, ByVal value As T) As T
        target = value
        Return value
    End Function
End Class