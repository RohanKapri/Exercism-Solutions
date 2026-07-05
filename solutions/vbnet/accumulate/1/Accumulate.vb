Imports System.Runtime.CompilerServices

Module AccumulateExtensions
 <Extension()>
Iterator Function Accumulate(Of TSource, TResult)(
    source As IEnumerable(Of TSource),
    operation As Func(Of TSource, TResult)
) As IEnumerable(Of TResult)
    
    Dim results As New List(Of TResult)
    If source Is Nothing Then Throw New ArgumentNullException(NameOf(source))
    If operation Is Nothing Then Throw New ArgumentNullException(NameOf(operation))

    For Each item In source
     yield operation(item)
    Next
     
End Function
End Module