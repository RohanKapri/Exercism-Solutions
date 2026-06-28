module LineUp

let format (name: string) (number: int): string =
    let suffix =
        let lastTwo = number % 100
        if lastTwo >= 11 && lastTwo <= 13 then
            "th"
        else
            match number % 10 with
            | 1 -> "st"
            | 2 -> "nd"
            | 3 -> "rd"
            | _ -> "th"

    $"{name}, you are the {number}{suffix} customer we serve today. Thank you!"