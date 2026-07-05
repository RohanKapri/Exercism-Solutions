Imports System

Public Module ErrorHandling
    Public Sub HandleErrorByThrowingException()
        Throw New Exception()
    End Sub

    Public Function HandleErrorByReturningNullableType(ByVal input As String) As Integer?
        Dim number As Integer
        If Integer.TryParse(input, number) Then
            Return number
        Else
            Return Nothing
        End If
    End Function

    Public Function HandleErrorWithOutParam(ByVal input As String, ByRef result As Integer) As Boolean
        Return Integer.TryParse(input, result)
    End Function

    Public Sub DisposableResourcesAreDisposedWhenExceptionIsThrown(ByVal disposableResource As IDisposable)
        Using disposableResource
            Throw New Exception()
        End Using
    End Sub
End Module