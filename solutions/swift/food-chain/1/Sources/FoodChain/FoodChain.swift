struct FoodChain {
    private static let chain = ["fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse"]

    static func song(start: Int, end: Int) -> String {
        let verses = (start...end).map { number in
            let animal = chain[number - 1]

            if animal == "fly" {
                return beginning(for: "fly")
            }

            if animal == "horse" {
                return beginning(for: "horse")
            }

            return beginning(for: animal) + litany(from: number - 1)
        }

        return verses.joined(separator: "\n\n")
    }

    private static func beginning(for animal: String) -> String {
        let verse = reaction(for: animal)

        if animal == "spider" {
            return intro(for: "spider") + "It " + verse
        }

        return intro(for: animal) + verse
    }

    private static func intro(for animal: String) -> String {
        "I know an old lady who swallowed a \(animal).\n"
    }

    private static func reaction(for animal: String) -> String {
        switch animal {
        case "spider": return "wriggled and jiggled and tickled inside her.\n"
        case "bird": return "How absurd to swallow a bird!\n"
        case "cat": return "Imagine that, to swallow a cat!\n"
        case "dog": return "What a hog, to swallow a dog!\n"
        case "goat": return "Just opened her throat and swallowed a goat!\n"
        case "cow": return "I don't know how she swallowed a cow!\n"
        case "horse": return "She's dead, of course!"
        default: return "I don't know why she swallowed the fly. Perhaps she'll die."
        }
    }

    private static func litany(from index: Int) -> String {
        let lines = stride(from: index, to: 0, by: -1).map { current in
            let currentAnimal = chain[current]
            let previousAnimal = chain[current - 1]

            let line = "She swallowed the \(currentAnimal) to catch the \(previousAnimal)"

            if previousAnimal == "spider" {
                return line + " that " + reaction(for: "spider")
            }

            if previousAnimal == "fly" {
                return line + ".\n" + reaction(for: "fly")
            }

            return line + ".\n"
        }

        return lines.joined()
    }
}