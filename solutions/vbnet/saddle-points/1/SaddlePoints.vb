Imports System.Linq
Imports System.Collections.Generic

Public Module SaddlePoints
    Public Function Calculate(ByVal matrix As Integer(,)) As IEnumerable(Of (Integer, Integer))
        Dim rowIndexer = Enumerable.Range(0, matrix.GetLength(0))
        Dim colIndexer = Enumerable.Range(0, matrix.GetLength(1))
        
        Dim rows = From i In rowIndexer
                   Select From j In colIndexer
                   Select matrix(i, j)
        
        Dim cols = From i In colIndexer
                   Select From j In rowIndexer
                   Select matrix(j, i)
        
        Dim saddlePoints = From i In rowIndexer
                           From j In colIndexer
                           Where rows.ElementAt(i).All(Function(x) matrix(i, j) >= x)
                           Where cols.ElementAt(j).All(Function(x) matrix(i, j) <= x)
                           Select (i + 1, j + 1)
        
        Return saddlePoints
    End Function
End Module