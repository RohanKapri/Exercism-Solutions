import Foundation

let gigasecond = 1e9

func gigasecond(from: Date) -> Date {
    from.addingTimeInterval(gigasecond)
}