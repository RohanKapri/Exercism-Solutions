import Foundation

struct Meetup {
    private let date: Date
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    init(year: Int, month: Int, week: String, weekday: String) {
        date = Self.date(year: year, month: month, week: week, weekday: weekday)!
    }

    var description: String {
        Self.formatter.string(from: date)
    }

    private enum Weekday: String {
        case sunday = "Sunday"
        case monday = "Monday"
        case tuesday = "Tuesday"
        case wednesday = "Wednesday"
        case thursday = "Thursday"
        case friday = "Friday"
        case saturday = "Saturday"

        var calendarWeekday: Int {
            switch self {
            case .sunday:    return 1
            case .monday:    return 2
            case .tuesday:   return 3
            case .wednesday: return 4
            case .thursday:  return 5
            case .friday:    return 6
            case .saturday:  return 7
            }
        }
    }

    private enum Week: String {
        case first, second, third, fourth, last, teenth

        var ordinal: Int? {
            switch self {
            case .first:  return 1
            case .second: return 2
            case .third:  return 3
            case .fourth: return 4
            case .last:   return -1
            case .teenth: return nil
            }
        }
    }

    private static func date(year: Int, month: Int, week: String, weekday: String) -> Date? {
        guard let targetWeek = Week(rawValue: week),
              let calendarWeekday = Weekday(rawValue: weekday)?.calendarWeekday else {
            return nil
        }

        if let ordinal = targetWeek.ordinal {
            return Calendar.current.date(from: DateComponents(
                year: year, month: month,
                weekday: calendarWeekday,
                weekdayOrdinal: ordinal
            ))
        }

        return teenthDate(year: year, month: month, weekday: calendarWeekday)
    }

    private static func teenthDate(year: Int, month: Int, weekday: Int) -> Date? {
        (13...19).compactMap {
            Calendar.current.date(from: DateComponents(year: year, month: month, day: $0))
        }.first { date in
            Calendar.current.component(.weekday, from: date) == weekday
        }
    }
}