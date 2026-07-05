Module Program
    Function Distance _
        (ByVal firstStrand As String,
         ByVal secondStrand As String) As Integer
    
        If Len(firstStrand) <> Len(secondStrand) Then Throw New ArgumentException
      
        Return firstStrand.Zip(secondStrand) _
               .Count(Function(pair) pair.First <> pair.Second)
    End Function
End Module