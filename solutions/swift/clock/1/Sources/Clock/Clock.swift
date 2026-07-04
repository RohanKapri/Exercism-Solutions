struct Clock {
    private let totalMinutes: Int

    init(hours: Int, minutes: Int = 0) {
        totalMinutes = Clock.minutesSinceMidnight(hours * 60 + minutes)
    }

    func add(minutes: Int) -> Clock {
        Clock(totalMinutes: totalMinutes + minutes)
    }

    func subtract(minutes: Int) -> Clock {
        add(minutes: -minutes)
    }

    private init(totalMinutes: Int) {
        self.totalMinutes = Clock.minutesSinceMidnight(totalMinutes)
    }

    private static func minutesSinceMidnight(_ minutes: Int) -> Int {
        (minutes % 1440 + 1440) % 1440
    }
}

extension Clock: Equatable {
    static func == (lhs: Clock, rhs: Clock) -> Bool {
        lhs.totalMinutes == rhs.totalMinutes
    }
}

extension Clock: CustomStringConvertible {
    var description: String {
        let h = totalMinutes / 60
        let m = totalMinutes % 60
        return "\(h < 10 ? "0" : "")\(h):\(m < 10 ? "0" : "")\(m)"
    }
}