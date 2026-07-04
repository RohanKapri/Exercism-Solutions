enum SeriesError: Error {
    case sliceLengthLongerThanSeries
    case sliceLengthZeroOrLess
    case emptySeries
}

struct Series {
    private let digits: String

    init(_ series: String) {
        digits = series
    }

    func slice(_ sliceSize: Int) throws -> [String] {
        guard !digits.isEmpty else {
            throw SeriesError.emptySeries
        }

        guard sliceSize > 0 else {
            throw SeriesError.sliceLengthZeroOrLess
        }

        guard sliceSize <= digits.count else {
            throw SeriesError.sliceLengthLongerThanSeries
        }

        return digits.slice(by: sliceSize)
    }
}

fileprivate extension String {
    func slice(by size: Int) -> [String] {
        (0...count - size).map { String(dropFirst($0).prefix(size)) }
    }
}