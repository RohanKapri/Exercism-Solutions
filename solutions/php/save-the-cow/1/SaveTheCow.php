<?php
// Exercise: Save the Cow a guessing game.

declare(strict_types=1);

// Save the Cow Game Class
class SaveTheCow
{
    /**
     * In PHP 8.4 and newer you can use Asymmetric Property Visibility to enhance data encapsulation
     * @see https://www.php.net/manual/en/language.oop5.visibility.php#language.oop5.visibility-members-aviz
     */
    const MAX_FAILURES = 10;
    public private(set) string $state;
    public private(set) string $maskedWord;
    public private(set) int $remainingFailures;
    private array $guesses;
    private string $word;
    private bool $outOfGuesses;

    // Build the SaveTheCow object.
    // @param $word: The secret word to guess.
    public function __construct(string $word)
    {
        $this->guesses = array();
        $this->remainingFailures = self::MAX_FAILURES - 1;
        $this->outOfGuesses = false;
        $this->word = strtolower($word);
        $this->MaskWord();
        $this->CalculateState();
    }

    // Recalculate the game state Win/Lose/Ongoing
    private function CalculateState() {
        if ($this->outOfGuesses) {
            $this->state = "Lose";
        } else if ($this->maskedWord == $this->word) {
            $this->state = "Win";
        } else {
            $this->state = "Ongoing";
        }
    }

    // Guess a letter. If you guess something you already guessed that is counted as a failure. You should not call this function
    // when the game is not in the ongoing state.
    // @param $guess: The letter to guess. This should be a lower case letter between "a", and "z".
    public function guess($guess) {
        if ($this->state == "Lose") {
            throw new Exception("cannot guess after the game is lost");
        } else if ($this->state == "Win") {
            throw new Exception("cannot guess after the game is won");
        }
        if (in_array($guess, $this->guesses)) {
            $this->remainingFailures--;
        } else {
            if (!str_contains($this->word, $guess)) {
                $this->remainingFailures--;
            }
            $this->guesses[] = $guess;
        }
        if ($this->remainingFailures < 0) {
            $this->remainingFailures = 0;
            $this->outOfGuesses = true;
        }
        $this->MaskWord();
        $this->CalculateState();
    }

    // Recalculate the masked word based on what letters have been give.
    // Alphabet characters (lower case) a-z will be themself if guessed and underscore (_) if not guessed yet.
    // Non alphabetic characters pass through as if guessed.
    private function MaskWord() {
        $result = "";
        foreach (str_split($this->word) as $letter) {
            if ($letter >= "a" && $letter <= "z") {
                if (in_array($letter, $this->guesses)) {
                    $result .= $letter;
                } else {
                    $result .= "_";
                }
            } else {
                $result .= $letter;
            }
        }
        $this->maskedWord = $result;
    }
}