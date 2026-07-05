Imports System
Imports Newtonsoft.Json


Public Class RestApi

    Private _users As List(Of User)

    Public Sub New(ByVal database As String)

        _users = JsonConvert.DeserializeObject(Of List(Of User))(database)

    End Sub

    Public Function [Get](ByVal _url As String, ByVal Optional payload As String = Nothing) As String

        If payload = "[]" Then
            Return payload
        End If

        If payload Is Nothing Then
            Return JsonConvert.SerializeObject(_users)
        End If

        Dim target = JsonConvert.DeserializeObject(Of Dictionary(Of String, List(Of String)))(payload)("users")

        Return JsonConvert.SerializeObject(_users.FindAll(Function(user) target.Contains(user.Name)))

    End Function

    Public Function Post(ByVal url As String, ByVal payload As String) As String

        If url = "/iou" Then
            Return iou(payload)
        End If

        Dim name As String = JsonConvert.DeserializeObject(Of Dictionary(Of String, String))(payload)("user")

        _users.Add(New User With {.Name = name})

        Dim result = JsonConvert.SerializeObject(_users.FindAll(Function(user) user.Name = name))

        Return result.Trim({"["c, "]"c})

    End Function

    Private Function iou(ByVal payload As String) As String

        Dim transact = JsonConvert.DeserializeObject(Of Transaction)(payload)

        _users.Find(Function(user) user.Name = transact.Lender).UpdateDebtors(transact.Borrower, transact.Amount)
        _users.Find(Function(user) user.Name = transact.Borrower).UpdateCreditors(transact.Lender, transact.Amount)

        Return JsonConvert.SerializeObject(_users.FindAll(Function(user) user.Name = transact.Lender OrElse user.Name = transact.Borrower))

    End Function

End Class


Public Class User
    Public Property Name As String
    Public Property Owes As New SortedDictionary(Of String, Integer)
    Public Property OwedBy As New SortedDictionary(Of String, Integer)

    Public ReadOnly Property Balance As Integer

        Get
            Dim totalOwedBy As Integer
            Dim totalOwes As Integer

            For Each amount In OwedBy.Values
                totalOwedBy += amount
            Next

            For Each amount In Owes.Values
                totalOwes += amount
            Next

            Return totalOwedBy - totalOwes
        End Get

    End Property

    Public Sub UpdateDebtors(ByVal borrower As String, ByVal amount As Integer)

        Dim currentDebt, currentCredit As Integer

        If Owes.TryGetValue(borrower, currentDebt) Then
            If currentDebt = amount Then Owes.Remove(borrower)
            If currentDebt > amount Then Owes(borrower) -= amount

            If currentDebt < amount Then
                OwedBy(borrower) = (If(OwedBy.TryGetValue(borrower, currentCredit), currentCredit, 0)) + amount - currentDebt
                Owes.Remove(borrower)
            End If
        Else
            OwedBy(borrower) = (If(OwedBy.TryGetValue(borrower, currentCredit), currentCredit, 0)) + amount
        End If

    End Sub

    Public Sub UpdateCreditors(ByVal lender As String, ByVal amount As Integer)

        Dim currentDebt, currentCredit As Integer

        If OwedBy.TryGetValue(lender, currentCredit) Then
            If currentCredit = amount Then OwedBy.Remove(lender)
            If currentCredit > amount Then OwedBy(lender) -= amount

            If currentCredit < amount Then
                Owes(lender) = (If(Owes.TryGetValue(lender, currentDebt), currentDebt, 0)) + amount - currentCredit
                OwedBy.Remove(lender)
            End If
        Else
            Owes(lender) = (If(Owes.TryGetValue(lender, currentDebt), currentDebt, 0)) + amount
        End If

    End Sub

End Class

Public Class Transaction
    Public Property Lender As String
    Public Property Borrower As String
    Public Property Amount As Integer

End Class

                                    