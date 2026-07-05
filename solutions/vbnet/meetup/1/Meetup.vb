Imports System
Imports System.Collections.Generic

Public Enum Schedule
    Teenth
    First
    Second
    Third
    Fourth
    Last
End Enum

Public Class Meetup
    Private ReadOnly _month As Integer
    Private ReadOnly _year As Integer

    Public Sub New(ByVal month As Integer, ByVal year As Integer)
        _month = month
        _year = year
    End Sub

    Public Function Day(ByVal dayOfWeek As DayOfWeek, ByVal schedule As Schedule) As DateTime
        Dim firstDay = New DateTime(_year, _month, If(schedule = Schedule.Teenth, 13, If(schedule = Schedule.First, 1, If(schedule = Schedule.Second, 8, If(schedule = Schedule.Third, 15, If(schedule = Schedule.Fourth, 22, DateTime.DaysInMonth(_year, _month) - 6))))))
        Return firstDay.AddDays((dayOfWeek - firstDay.DayOfWeek + 7) Mod 7)
    End Function
End Class