class TwelveDaysSong {
    static func recite(start: Int, end: Int) -> String {
        guard (1...12).contains(start), (1...12).contains(end), start <= end else { return "" }
        
        let intro = "On the "
        let ordinals = ["",
                        "first", "second", "third", "fourth", "fifth",
                        "sixth", "seventh", "eighth", "ninth", "tenth",
                        "eleventh", "twelfth"]
        let middle = " day of Christmas my true love gave to me: "
        let gifts = ["",
                     "a Partridge in a Pear Tree", "two Turtle Doves",
                     "three French Hens", "four Calling Birds", "five Gold Rings",
                     "six Geese-a-Laying", "seven Swans-a-Swimming",
                     "eight Maids-a-Milking", "nine Ladies Dancing",
                     "ten Lords-a-Leaping", "eleven Pipers Piping",
                     "twelve Drummers Drumming"]
        
        var lyrics = [String]()
        
        for day in start...end {
            var partTwo = ""
            for gift in (1...day).reversed() {
                partTwo += gift == 1 && day != 1 ? ", and " : (gift != day ? ", " : "")
                partTwo += gifts[gift]
            }
            let lyric = "\(intro)\(ordinals[day])\(middle)\(partTwo)."
            lyrics.append(lyric)
        }
        
        return lyrics.joined(separator: "\n")
    }
}