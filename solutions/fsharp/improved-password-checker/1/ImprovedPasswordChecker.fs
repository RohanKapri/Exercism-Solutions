module ImprovedPasswordChecker

open System

[<Flags>]
type PasswordError =
    | LessThan12Characters = 1
    | MissingUppercaseLetter = 2
    | MissingLowercaseLetter = 4
    | MissingDigit = 8
    | MissingSymbol = 16

/// Validate the given password against the rules defined in the instructions.
let checkPassword (password: string) : Result<string, PasswordError> =
    let mutable errors = enum<PasswordError> 0
    let symbols = "!@#$%^&*"

    // Rule 1: Must have 12 or more characters
    if password.Length < 12 then
        errors <- errors ||| PasswordError.LessThan12Characters

    // Rule 2: Must have at least one uppercase letter
    if not (String.exists Char.IsUpper password) then
        errors <- errors ||| PasswordError.MissingUppercaseLetter

    // Rule 3: Must have at least one lowercase letter
    if not (String.exists Char.IsLower password) then
        errors <- errors ||| PasswordError.MissingLowercaseLetter

    // Rule 4: Must have at least one digit
    if not (String.exists Char.IsDigit password) then
        errors <- errors ||| PasswordError.MissingDigit

    // Rule 5: Must have at least one symbol in the set !@#$%^&*
    if not (String.exists (fun c -> symbols.Contains(c)) password) then
        errors <- errors ||| PasswordError.MissingSymbol

    if errors = enum<PasswordError> 0 then
        Ok password
    else
        Error errors

/// Return a list of human-readable phrases indicating the meaning of the given result value.
let getStatusPhrases (result: Result<string, PasswordError>) : string list =
    match result with
    | Ok _ -> ["OK"]
    | Error errors ->
        [
            if errors.HasFlag(PasswordError.LessThan12Characters) then "12 characters"
            if errors.HasFlag(PasswordError.MissingUppercaseLetter) then "uppercase letter"
            if errors.HasFlag(PasswordError.MissingLowercaseLetter) then "lowercase letter"
            if errors.HasFlag(PasswordError.MissingDigit) then "digit"
            if errors.HasFlag(PasswordError.MissingSymbol) then "symbol"
        ]


        