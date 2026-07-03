import Foundation

func splitOnNewlines(_ poem: String) -> [String] {
    poem.components(separatedBy: "\n")
}

func frontDoorPassword(_ poem: String) -> String {
    splitOnNewlines(poem).map(firstLetter).joined()
}

private func firstLetter(in line: String) -> String {
    line.first.map(String.init) ?? "_"
}

func backDoorPassword(_ poem: String) -> String {
    splitOnNewlines(poem)
        .map { lastLetter(in: trim($0)) }
        .joined()
        .appending(", please")
}

private func trim(_ line: String) -> String {
    line.trimmingCharacters(in: .whitespacesAndNewlines)
}

func lastLetter(in line: String) -> String {
    line.last.map(String.init) ?? "_"
}
    
func secretRoomPassword(_ poem: String) -> String {
    splitOnNewlines(poem)
        .enumerated()
        .map { (index, line) in ithLetter(in: line, at: index) }
        .map { letter in letter.uppercased() }
        .joined()
        .appending("!")
}

func ithLetter(in line: String, at index: Int) -> Character {
    guard let index = line.index(line.startIndex, offsetBy: index, limitedBy: line.endIndex) else {
        return " "
    }

    return line[index]
}