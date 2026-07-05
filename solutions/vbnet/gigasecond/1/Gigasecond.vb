Imports System

Public Module Gigasecond
    Public Function Add(ByVal moment As Date) As Date
        Return moment.AddSeconds(1_000_000_000)
    End Function
End Module
