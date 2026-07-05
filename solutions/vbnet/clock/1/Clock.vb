Imports System.Globalization

''' <summary>
''' Immutable class that represents a time consisting of hours and minutes but no date part.
''' </summary>
Public Class Clock

    'Private Fields
    Private Const TicksPerDay As Int64 = 24L * 60L * 60L * 10000000L
    Private Const HoursPerDay As Int32 = 24
    Private Const MinutesPerDay As Int32 = 24 * 60
    Private ReadOnly Time As TimeSpan

    'Constructors

    ''' <summary>
    ''' Constructs a new instance of <see cref="Clock"/> using the given hours and minutes. Both values are allowed to
    ''' exceed a day or an hour, e.g. "25, 1441" is valid and interpreted as "01:01", also negative values are allowed but
    ''' make sure to pass them correctly, "-1, -30" => 24:00 - 1h - 30min => 22:30 but "-1, 30" => 24:00 - 1h + 30min
    ''' => "23:30".
    ''' </summary>
    ''' <param name="hours">The number of hours in the range of <see cref="Int32.MinValue"/> to <see cref="Int32.MaxValue"/>.</param>
    ''' <param name="minutes">The number of minutes in the range of <see cref="Int32.MinValue"/> to <see cref="Int32.MaxValue"/>.</param>
    Public Sub New(ByVal hours As Integer, ByVal minutes As Integer)
        Me.New(TimeSpan.FromHours(hours Mod HoursPerDay) + TimeSpan.FromMinutes(minutes Mod MinutesPerDay))
    End Sub

    ''' <summary>
    ''' Constructs a new instance of <see cref="Clock"/> using the given <see cref="TimeSpan"/> structure.
    ''' </summary>
    ''' <param name="time">The <see cref="TimeSpan"/> to use (which may be greater than a day or less than zero).</param>
    Public Sub New(time As TimeSpan)
        Me.Time = NormalizeTime(time)
    End Sub

    'Public Methods

    ''' <summary>
    ''' The number of minutes to add to the current time, negative values and such exceeding an hour or a day are explicitly allowed.
    ''' </summary>
    ''' <param name="minutesToAdd">The number of minutes to add.</param>
    ''' <returns>A new <see cref="Clock"/> instance containing the result. The current instance is immutable.</returns>
    Public Function Add(ByVal minutesToAdd As Integer) As Clock
        Return New Clock(Time + TimeSpan.FromMinutes(minutesToAdd Mod MinutesPerDay))
    End Function

    ''' <summary>
    ''' The number of minutes to subtract from the current time, negative values and such exceeding an hour or a day are explicitly allowed.
    ''' </summary>
    ''' <param name="minutesToAdd">The number of minutes to add.</param>
    ''' <returns>A new <see cref="Clock"/> instance containing the result. The current instance is immutable.</returns>
    Public Function Subtract(ByVal minutesToSubtract As Integer) As Clock
        Return New Clock(Time - TimeSpan.FromMinutes(minutesToSubtract Mod MinutesPerDay))
    End Function

    ''' <summary>
    ''' Returns the represented time in the format "HH:mm".
    ''' </summary>
    Public Overrides Function ToString() As String
        Dim myTime As TimeSpan = Time
        Dim myFormatProvider As IFormatProvider = CultureInfo.InvariantCulture
        Dim myHours As String = myTime.Hours.ToString("00", myFormatProvider)
        Dim myMinutes As String = myTime.Minutes.ToString("00", myFormatProvider)
        Return $"{myHours}:{myMinutes}"
    End Function

    ''' <inheritdoc/>
    Public Overrides Function Equals(obj As Object) As Boolean
        If (TypeOf obj IsNot Clock) Then Return False
        Dim other As Clock = DirectCast(obj, Clock)
        Dim result As Boolean = (other.Time = Time)
        Return result
    End Function

    'Private Methods

    Private Shared Function NormalizeTime(time As TimeSpan) As TimeSpan
        Dim ticks As Int64 = time.Ticks Mod TicksPerDay
        If (ticks < 0L) Then ticks += TicksPerDay
        Return New TimeSpan(ticks)
    End Function

End Class