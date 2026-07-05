Imports System
Imports System.Collections.Generic
Imports System.Linq

Public Module BookStore
    Private Const BookPrice As Decimal = 8.0D

    Public Function Total(books As Integer()) As Decimal
        If books.Length = 0 Then
            Return 0.0D
        End If

        Dim bookGroups = BookGroupsWithCount(books)
        Return Enumerable.Range(1, bookGroups.Length) _
            .Min(Function(size) CalculateTotalCost(bookGroups, size, 0.0D))
    End Function

    Private Function BookGroupsWithCount(books As Integer()) As Integer()
        Return books _
            .GroupBy(Function(book) book) _
            .Select(Function(book) book.Count()) _
            .OrderByDescending(Function(book) book) _
            .ToArray()
    End Function

    Private Function CalculateTotalCost(bookGroups As Integer(), numberOfBooksToRemove As Integer, totalCost As Decimal) As Decimal
        Dim numberOfBooks = Math.Min(numberOfBooksToRemove, bookGroups.Length)
        If numberOfBooks = 0 Then
            Return totalCost + RegularPrice(bookGroups.Sum())
        End If

        Dim updatedBookGroups = RemoveBooks(bookGroups, numberOfBooks)
        Dim updatedTotalCost = totalCost + BooksPrice(numberOfBooks)
        Return CalculateTotalCost(updatedBookGroups, numberOfBooks, updatedTotalCost)
    End Function

    Private Function RemoveBooks(bookGroups As Integer(), numberOfBooks As Integer) As Integer()
        Return bookGroups _
            .Take(numberOfBooks) _
            .Select(AddressOf RemoveBook) _
            .Concat(bookGroups.Skip(numberOfBooks)) _
            .Where(Function(i) i > 0) _
            .OrderByDescending(Function(x) x) _
            .ToArray()
    End Function

    Private Function RemoveBook(books As Integer) As Integer
        Return books - 1
    End Function

    Private Function BooksPrice(differentBooks As Integer) As Decimal
        Return ApplyDiscount(RegularPrice(differentBooks), DiscountPercentage(differentBooks))
    End Function

    Private Function RegularPrice(books As Integer) As Decimal
        Return books * BookPrice
    End Function

    Private Function DiscountPercentage(differentBooks As Integer) As Decimal
        Select Case differentBooks
            Case 5
                Return 25.0D
            Case 4
                Return 20.0D
            Case 3
                Return 10.0D
            Case 2
                Return 5.0D
            Case Else
                Return 0.0D
        End Select
    End Function

    Private Function ApplyDiscount(price As Decimal, discountPercentage As Decimal) As Decimal
        Return Math.Round(price * (100.0D - discountPercentage) / 100.0D, 2)
    End Function
End Module