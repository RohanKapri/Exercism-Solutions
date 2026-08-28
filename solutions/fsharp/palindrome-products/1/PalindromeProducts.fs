module PalindromeProducts

type ProductData = {
    value : int
    factors : int * int
}

let isPalindrome n =
    let rec rev acc x =
        if x = 0 then acc
        else rev (acc * 10 + x % 10) (x / 10)
    let r = rev 0 n
    r = n

let palindromesByRange minFactor maxFactor=
    seq {for i in minFactor .. maxFactor do
            for j in i .. maxFactor do
                let value = i * j
                if isPalindrome value then
                    yield {
                        value = value
                        factors = if i < j then (i, j) else (j, i)
                    }
    }
    |> Seq.distinct
    |> Seq.sortBy (fun p -> p.value)

let processPalindromes palindromes =
    if Seq.length palindromes = 0 then None, []
    else 
        let minPalValue = 
            Seq.head palindromes 
            |> fun p -> p.value

        let minPalFactors =
            palindromes
            |> Seq.filter (fun p -> p.value = minPalValue)
            |> Seq.map (fun p -> p.factors)
            |> Seq.toList
            |> List.sortBy (fun (a, _) -> a)
        
        Some minPalValue, minPalFactors

let validate smallest largest =
    if smallest > largest then raise (System.ArgumentException())


let smallest minFactor maxFactor = 
    validate minFactor maxFactor
    palindromesByRange minFactor maxFactor    
    |> processPalindromes


let largest minFactor maxFactor = 
    validate minFactor maxFactor
    palindromesByRange minFactor maxFactor
    |> Seq.rev
    |> processPalindromes
    