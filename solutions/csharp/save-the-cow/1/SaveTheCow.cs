using System.Collections.Immutable;
using System.Reactive.Subjects;

/// <summary>
/// Game State
/// </summary>
public class GameState
{
    /// <summary>
    /// Return the word but with unguessed characters masked.
    /// </summary>
    public string MaskedWord { 
        get
        {
            return MaskWord();
        } 
    }

    /// <summary>
    /// The set of characters guessed so far. 
    /// </summary>
    public ImmutableHashSet<char> GuessedChars { 
        get
        {
            return [.. guessedChars];
        }
    }

    /// <summary>
    /// How many guesses are remaining.
    /// </summary>
    public int RemainingGuesses { get
        {
            return remainingGuesses;
        } 
    }

    private string word;
    private HashSet<char> guessedChars;
    private int remainingGuesses;

    /// <summary>
    /// Constructor - Creates a new Game State instance
    /// </summary>
    /// <param name="word">The word to guess</param>
    /// <param name="guessedChars">The characters guessed so far</param>
    /// <param name="remainingGuesses">How many guesses we have left</param>
    public GameState(string word, ImmutableHashSet<char> guessedChars, int remainingGuesses)
    {
        this.word = word;
        this.guessedChars = new HashSet<char>(guessedChars.AsEnumerable<char>());
        this.remainingGuesses = remainingGuesses;
    }

    /// <summary>
    /// Calculate the word with unguessed characters masked with an _.
    /// </summary>
    /// <returns>Word but with unguessed characters replaced with an underscore (_).</returns>
    private string MaskWord()
    {
        char[] characters = new char[word.Length];
        for(int i = 0; i < word.Length; i++)
        {
            char c = word[i];
            if (guessedChars.Contains(c)) {
                characters[i] = c;
            } else
            {
                characters[i] = '_';
            }
        }
        return new string(characters);
    }

    /// <summary>
    /// Is the game finished - Have all characters in the word been guessed.
    /// </summary>
    /// <returns>Boolean true if game has been won and false otherwise. 
    /// Doesn't take too many turns into account.
    /// </returns>
    public bool IsComplete()
    {
        for(int i = 0; i < word.Length; i++)
        {
            if (!guessedChars.Contains(word[i])) {
                return false;
            }
        }
        return true;
    }
}

/// <summary>
/// Custom exception for too many turns.
/// </summary>
public class TooManyGuessesException : Exception
{
}

/// <summary>
/// Play the game of save the cow. Guess all the letters in the pass phrase before the cow gets it.
/// </summary>
public class SaveTheCow
{
    // I shouldn't have to steal from community solutions to see subject, and behavior subject.
    // Give us a bone. I had a longer more complicated thing working but it took way too long.
    private readonly Subject<char> _guesses = new Subject<char>();
    private readonly BehaviorSubject<GameState> _state;
    public IObservable<GameState> StateObservable => _state;
    public IObserver<char> GuessObserver => _guesses;
    private string word;
    GameState gs;

    /// <summary>
    /// Constructor
    /// </summary>
    /// <param name="word">Start a new game of save the cow with word and the passphrase to guess.</param>
    public SaveTheCow(string word)
    { 
        this.word = word;
        gs= new GameState(word, ImmutableHashSet<char>.Empty, 9); 
        _state = new BehaviorSubject<GameState>(gs);   
        _guesses.Subscribe(OnNext);
    }

    /// <summary>
    /// Called by subject when a new guess has been submitted.
    /// </summary>
    /// <param name="c">The guessed character</param>
    public void OnNext(char c)
    {
        int guesses = (word.Contains(c) && !gs.GuessedChars.Contains(c)) ? gs.RemainingGuesses : gs.RemainingGuesses - 1;
        gs = new(word, [.. gs.GuessedChars, c], guesses);

        if (gs.RemainingGuesses < 0)
        {
            _state.OnError(new TooManyGuessesException());
        } else if (gs.IsComplete()) {
            _state.OnCompleted();
        } else
        {
            _state.OnNext(gs);            
        }
    }
}