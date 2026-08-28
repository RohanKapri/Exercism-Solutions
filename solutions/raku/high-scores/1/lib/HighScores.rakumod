unit class HighScores;

has @.scores;

method scores             { @!scores              }
method latest             { @!scores.tail         }
method personal-best      { @!scores.max          }
method personal-top-three { @!scores.sort.tail: 3 }