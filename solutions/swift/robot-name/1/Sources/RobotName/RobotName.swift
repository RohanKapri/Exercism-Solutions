import Foundation

struct Robot {
    private(set) var name: String

    private nonisolated(unsafe) static var usedNames: Set<String> = []
    private static let lock = NSLock()

    init() {
        name = Self.uniqueName()
    }

    mutating func resetName() {
        name = Self.uniqueName()
    }

    private static func uniqueName() -> String {
        lock.withLock {
            var candidate: String
            repeat {
                candidate = "\(randomLetters())\(randomDigits())"
            } while usedNames.contains(candidate)

            usedNames.insert(candidate)

            return candidate
        }
    }

    private static func randomLetters() -> String {
        randomCharacters(from: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", count: 2)
    }

    private static func randomDigits() -> String {
        randomCharacters(from: "1234567890", count: 3)
    }

    private static func randomCharacters(from pool: String, count: Int) -> String {
        String((0..<count).compactMap { _ in pool.randomElement() })
    }
}