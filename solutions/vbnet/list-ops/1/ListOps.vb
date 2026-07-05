Imports System
Imports System.Collections.Generic
Imports System.Linq

Public Module ListOps
    Public Function Length(Of T)(ByVal input As List(Of T)) As Integer
        Return input.Count
    End Function

    Public Function Reverse(Of T)(ByVal input As List(Of T)) As List(Of T)
        Return Enumerable.Reverse(input).ToList()
    End Function

    Public Function Map(Of TIn, TOut)(ByVal inputList As List(Of TIn), ByVal mapFunc As Func(Of TIn, TOut)) As List(Of TOut)
        Return inputList.[Select](mapFunc).ToList()
    End Function

    Public Function Filter(Of T)(ByVal input As List(Of T), ByVal predicate As Func(Of T, Boolean)) As List(Of T)
        Return input.Where(predicate).ToList()
    End Function

    Public Function Foldl(Of TIn, TOut)(ByVal input As List(Of TIn), ByVal start As TOut, ByVal func As Func(Of TOut, TIn, TOut)) As TOut
        Return input.Aggregate(start, func)
    End Function

    Public Function Foldr(Of TIn, TOut)(ByVal input As List(Of TIn), ByVal start As TOut, ByVal func As Func(Of TIn, TOut, TOut)) As TOut
        Return Enumerable.Reverse(input).Aggregate(start, Function(acc, x) func(x, acc))
    End Function

    Public Function Concat(Of T)(ByVal input As List(Of List(Of T))) As List(Of T)
        Return input.SelectMany(Function(x) x).ToList()
    End Function

    Public Function Append(Of T)(ByVal left As List(Of T), ByVal right As List(Of T)) As List(Of T)
        Return left.Concat(right).ToList()
    End Function
End Module