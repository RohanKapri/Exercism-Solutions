Imports System.Collections.Immutable
Imports System.Reactive.Subjects

Public Class GameState
    Public ReadOnly Property MaskedWord As String
    Public ReadOnly Property GuessedChars As ImmutableHashSet(Of Char)
    Public ReadOnly Property RemainingGuesses As Integer

    Public Sub New(maskedWord As String,
                   guessedChars As ImmutableHashSet(Of Char),
                   remainingGuesses As Integer)

        Me.MaskedWord = maskedWord
        Me.GuessedChars = guessedChars
        Me.RemainingGuesses = remainingGuesses
    End Sub
End Class

Public Class TooManyGuessesException
    Inherits Exception
End Class

Public Class SaveTheCow

    Private ReadOnly word As String
    Private ReadOnly subject As Subject(Of GameState)
    Private guessed As ImmutableHashSet(Of Char)
    Private remaining As Integer
    Private gameOver As Boolean

    Public ReadOnly Property StateObservable As IObservable(Of GameState)
    Public ReadOnly Property GuessObserver As IObserver(Of Char)

    Public Sub New(ByVal word As String)

        Me.word = word
        Me.subject = New Subject(Of GameState)()
        Me.guessed = ImmutableHashSet(Of Char).Empty
        Me.remaining = 9
        Me.gameOver = False

        StateObservable = subject

        GuessObserver = Observer.Create(Of Char)(
            Sub(ch)
                MakeGuess(ch)
            End Sub
        )

        ' Initial state
        subject.OnNext(
            New GameState(
                GetMaskedWord(),
                guessed,
                remaining
            )
        )

    End Sub

    Private Sub MakeGuess(ByVal ch As Char)

        If gameOver Then
            Throw New InvalidOperationException()
        End If

        ' Correct only if it exists and was not guessed before
        If word.Contains(ch) AndAlso Not guessed.Contains(ch) Then
            guessed = guessed.Add(ch)
        Else
            remaining -= 1
        End If

        Dim state As New GameState(
            GetMaskedWord(),
            guessed,
            remaining
        )

        subject.OnNext(state)

        ' Win has priority
        If GetMaskedWord() = word Then
            gameOver = True
            subject.OnCompleted()
            Return
        End If

        ' Lose after 10 failures
        If remaining = 0 Then
            gameOver = True
            subject.OnError(New TooManyGuessesException())
        End If

    End Sub

    Private Function GetMaskedWord() As String

        Dim result As String = ""

        For Each ch As Char In word
            If guessed.Contains(ch) Then
                result &= ch
            Else
                result &= "_"
            End If
        Next

        Return result

    End Function

End Class