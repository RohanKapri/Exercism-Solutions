struct Size {
    var width = 80  // required
    var height = 60  // required

    static func ofRectangle(from: Position, to: Position) -> Self {
        to - from
    }

    // required
    mutating func resize(newWidth: Int, newHeight: Int) {
        width = newWidth
        height = newHeight
    }

    mutating func setBounds(min minSize: Self) {
        if width < minSize.width { width = minSize.width }
        if height < minSize.height { height = minSize.height }
    }

    mutating func setBounds(max maxSize: Self) {
        if width > maxSize.width { width = maxSize.width }
        if height > maxSize.height { height = maxSize.height }
    }

    mutating func setBounds(min: Self, max: Self) {
        setBounds(max: max)
        setBounds(min: min)
    }

    func clamped(min: Self, max: Self) -> Self {
        var result = self
        result.setBounds(min: min, max: max)
        return result
    }
}

struct Position {
    static let origin = Self()

    var x = 0  // required
    var y = 0  // required

    // required
    mutating func moveTo(newX: Int, newY: Int) {
        x = newX
        y = newY
    }

    mutating func setBounds(min: Self) {
        if x < min.x { x = min.x }
        if y < min.y { y = min.y }
    }

    mutating func setBounds(max: Self) {
        if x > max.x { x = max.x }
        if y > max.y { y = max.y }
    }

    mutating func setBounds(min: Self, max: Self) {
        setBounds(max: max)
        setBounds(min: min)
    }

    func clamped(min: Self, max: Self) -> Self {
        var result = self
        result.setBounds(min: min, max: max)
        return result
    }

    /// distance
    static func - (self: Self, other: Self) -> Size {
        Size(
            width: self.x - other.x,
            height: self.y - other.y,
        )
    }

    // shift by vector (`Size`)

    static func += (self: inout Self, other: Size) {
        self.x += other.width
        self.y += other.height
    }

    static func -= (self: inout Self, other: Size) {
        self.x -= other.width
        self.y -= other.height
    }

    static func + (self: Self, other: Size) -> Self {
        var result = self
        result += other
        return result
    }

    static func - (self: Self, other: Size) -> Self {
        var result = self
        result -= other
        return result
    }
}

class Window {
    // required, but i made it static
    static let screenSize = Size(width: 800, height: 600)

    // not required
    static let endOfScreen = .origin + screenSize

    // required
    var title: String
    var size: Size
    var position: Position
    var contents: String?

    // required
    convenience init() {
        self.init(title: "New Window", contents: nil)
    }

    // required
    init(
        title: String,
        contents: String?,
        size: Size = Size(),
        position: Position = Position(),
    ) {
        self.title = title
        self.contents = contents
        self.size = size
        self.position = position
    }

    // required
    func resize(to newSize: Size) {
        size = newSize.clamped(
            min: Size(width: 1, height: 1),
            max: Size.ofRectangle(
                from: self.position,
                to: Self.endOfScreen,
            ),
        )
    }

    // required
    func move(to newPos: Position) {
        position = newPos.clamped(
            min: .origin,
            max: Self.endOfScreen - self.size,
        )
    }

    // required
    func update(title: String) { self.title = title }
    func update(text: String?) { contents = text }

    // required
    func display() -> String {
        let pos = (position.x, position.y)
        let w = size.width
        let h = size.height
        let size = "(\(w) x \(h))"
        let contents = contents ?? "[This window intentionally left blank]"

        // single newline in the end required
        return """
            \(title)
            Position: \(pos), Size: \(size)
            \(contents)

            """
    }
}