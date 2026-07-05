Imports System
Imports System.Collections.Generic
Imports System.Globalization
Imports System.Linq

Public Structure LedgerEntry
    Public Sub New(ByVal [date] As DateTime, ByVal desc As String, ByVal chg As Single)
        DateProp = [date]
        Me.Desc = desc
        Me.Chg = chg
    End Sub

    Public ReadOnly Property DateProp As DateTime
    Public ReadOnly Property Desc As String
    Public ReadOnly Property Chg As Single
End Structure

Module Ledger
    Function CreateEntry(ByVal dateStr As String, ByVal desc As String, ByVal chng As Integer) As LedgerEntry
        Return New LedgerEntry(DateTime.Parse(dateStr, CultureInfo.InvariantCulture), desc, chng / 100.0F)
    End Function

    Private Function CreateCulture(ByVal cur As String, ByVal loc As String) As CultureInfo
        If (cur <> "USD" AndAlso cur <> "EUR") OrElse (loc <> "nl-NL" AndAlso loc <> "en-US") Then Throw New ArgumentException("Invalid currency")
        Dim culture = New CultureInfo(loc)
        culture.NumberFormat.CurrencySymbol = If((cur = "USD"), "$", "€")
        culture.NumberFormat.CurrencyNegativePattern = If((loc = "nl-NL"), 12, 0)
        culture.DateTimeFormat.ShortDatePattern = If((loc = "nl-NL"), "dd/MM/yyyy", "MM/dd/yyyy")
        Return culture
    End Function

    Private Function PrintHead(ByVal loc As String) As String
        If loc <> "nl-NL" AndAlso loc <> "en-US" Then Throw New ArgumentException("Invalid currency")
        Return If((loc = "en-US"), "Date       | Description               | Change       ", "Datum      | Omschrijving              | Verandering  ")
    End Function

    Private Function Description(ByVal desc As String) As String
        Return If(desc.Length > 25, desc.Substring(0, 22) & "...", desc)
    End Function

    Private Function Change(ByVal culture As IFormatProvider, ByVal cgh As Single) As String
        Return If(cgh < 0.0, cgh.ToString("C", culture), cgh.ToString("C", culture) & " ")
    End Function

    Private Function PrintEntry(ByVal culture As IFormatProvider, ByVal entry As LedgerEntry) As String
        Return entry.DateProp.ToString("d", culture) & " | " & String.Format("{0,-25}", Description(entry.Desc)) & " | " & String.Format("{0,13}", Change(culture, entry.Chg))
    End Function

    Private Function Sort(ByVal entries As LedgerEntry()) As IEnumerable(Of LedgerEntry)
        Return entries.OrderBy(Function(x) x.DateProp & "@" & x.Desc & "@" & x.Chg).OrderBy(Function(e) Math.Sign(e.Chg))
    End Function

    Function Format(ByVal currency As String, ByVal locale As String, ByVal entries As LedgerEntry()) As String
        Return String.Join(vbLf, New String() {PrintHead(locale)}.Concat(Sort(entries).[Select](Function(e) PrintEntry(CreateCulture(currency, locale), e))))
    End Function
End Module