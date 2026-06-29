module Alphametics

let getLetters puzzle =
    let lastDigit = Array.map (fun (x: string) -> x[String.length x - 1]) puzzle |> Set.ofArray
    let allDigit = Array.map (fun x -> Set.ofSeq x) puzzle |> Set.unionMany
    let otherDigit = Set.difference allDigit lastDigit
    Set.toList lastDigit @ Set.toList otherDigit

let valid puzzle answer =
    if Array.exists (fun part -> String.length part > 1 && Map.tryFind part[0] answer = Some 0) puzzle then
        false
    else
        let lastDigits = Array.map (fun (part: string) -> part[String.length part - 1]) puzzle
        if Array.exists (fun digit -> not (Map.containsKey digit answer)) lastDigits then
            true
        else
            let digits = Array.map (fun digit -> Map.find digit answer) lastDigits
            let sum = Array.fold (+) 0 (Array.sub digits 0 (Array.length digits - 1))
            sum % 10 = digits[Array.length digits - 1]

let rec toNumber answer acc digits =
    if Seq.isEmpty digits then
        acc
    else
        let digit = Map.find (Seq.head digits) answer
        toNumber answer (acc * 10 + digit) (Seq.tail digits)

let check puzzle answer =
    let numbers = Array.map (toNumber answer 0) puzzle
    let sum = Array.fold (+) 0 (Array.sub numbers 0 (Array.length numbers - 1))
    sum = numbers[Array.length numbers - 1]

let rec dfs letters puzzle (used: bool array) answer =
    if not (valid puzzle answer) then
        None
    elif List.isEmpty letters then
        if check puzzle answer then
            Some answer
        else
            None
    else
        let now = List.head letters
        let mutable result = None
        for i in [0..9] do
            if Option.isNone result && not used[i] then
                used[i] <- true
                let tmp = dfs (List.tail letters) puzzle used (Map.add now i answer)
                if Option.isSome tmp then
                    result <- tmp
                else
                    used[i] <- false
        result

let solve (puzzle: string) =
    let puzzle = Array.filter (fun x -> x <> "+" && x <> "==") (puzzle.Split(" "))
    let letters = getLetters puzzle
    let used = Array.replicate 10 false
    if List.length letters <= 10 then
        dfs letters puzzle used Map.empty
    else
        None
