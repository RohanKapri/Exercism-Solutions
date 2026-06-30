namespace Bob

inductive ConversationType where
  | yelledQuestion : ConversationType
  | question       : ConversationType
  | yell           : ConversationType
  | silence        : ConversationType
  | other          : ConversationType

def ConversationType.reply : ConversationType -> String
  | .yelledQuestion => "Calm down, I know what I'm doing!"
  | .question       => "Sure."
  | .yell           => "Whoa, chill out!"
  | .silence        => "Fine. Be that way!"
  | .other          => "Whatever."

def isQuestion (text : String.Slice) : Bool :=
  text.revFind? (· == '?')
    |>.bind (fun q =>
      text.revFind? Char.isAlpha
        |>.map (decide $ q > ·)
        |>.getD true)
    |>.getD false

def isSilence (text : String.Slice) : Bool :=
  text.all Char.isWhitespace

def isYell (text : String.Slice) : Bool :=
  let hasLetter := text.contains Char.isAlpha
  let allUpper := text.all (λ c => !Char.isAlpha c || Char.isUpper c)
  hasLetter && allUpper

def classifyText (text : String.Slice) : ConversationType :=
  match isQuestion text, isYell text, isSilence text with
  | true, true, _ => .yelledQuestion
  | true, _, _    => .question
  | _, true, _    => .yell
  | _, _, true    => .silence
  | _, _, _       => .other

def response (heyBob : String) : String :=
  (classifyText heyBob.toSlice).reply

end Bob