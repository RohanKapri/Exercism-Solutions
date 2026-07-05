Imports System

Public Class BankAccount
    Private _open As Boolean
    Private _balance As Decimal
    Private ReadOnly _lock As New Object()

    Public Sub Open()
        ExecuteLockedVoid(Sub() _open = True)
    End Sub

    Public Sub Close()
        ExecuteLockedVoid(Sub() _open = False)
    End Sub

    Public ReadOnly Property Balance As Decimal
        Get
            Return ExecuteLocked(Of Decimal)(Function()
                                                 If Not _open Then
                                                     Throw New InvalidOperationException("Cannot check balance on a locked account.")
                                                 End If
                                                 Return _balance
                                             End Function)
        End Get
    End Property

    Public Sub UpdateBalance(change As Decimal)
        ExecuteLockedVoid(Sub() _balance += change)
    End Sub

    Private Sub ExecuteLockedVoid(action As Action)
        SyncLock _lock
            action.Invoke()
        End SyncLock
    End Sub

    Private Function ExecuteLocked(Of T)(func As Func(Of T)) As T
        SyncLock _lock
            Return func.Invoke()
        End SyncLock
    End Function
End Class