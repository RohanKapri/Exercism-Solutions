module PasswordChecker

type PasswordError =
    | LessThan12Characters
    | MissingUppercaseLetter
    | MissingLowercaseLetter
    | MissingDigit
    | MissingSymbol

let checkPassword (password: string) : Result<string, PasswordError> =
    if password |> String.length < 12 then
        Error LessThan12Characters
    elif password
         |> Seq.filter System.Char.IsLetter
         |> Seq.filter System.Char.IsUpper
         |> Seq.isEmpty then
        Error MissingUppercaseLetter
    elif password
         |> Seq.filter System.Char.IsLetter
         |> Seq.filter System.Char.IsLower
         |> Seq.isEmpty then
        Error MissingLowercaseLetter
    elif password
         |> Seq.filter System.Char.IsDigit
         |> Seq.isEmpty then
        Error MissingDigit
    elif seq "!@#$%^&*"
         |> Seq.exists password.Contains
         |> not then
        Error MissingSymbol
    else
        Ok password


/// Return a human-readable message indicating the meaning of the given result value.
let getStatusMessage (result: Result<string, PasswordError>) : string =
    match result with
    | Error LessThan12Characters -> "Error: does not have at least 12 characters"
    | Error MissingUppercaseLetter -> "Error: does not have at least one uppercase letter"
    | Error MissingLowercaseLetter -> "Error: does not have at least one lowercase letter"
    | Error MissingDigit -> "Error: does not have at least one digit"
    | Error MissingSymbol -> "Error: does not have at least one symbol"
    | Ok _ -> "OK"