enum LogLevel: Int {
    case trace, debug, info = 4, warning, error, fatal, unknown = 42
    
    init(_ line: String) {
        if line.hasPrefix("[TRC]") {
            self = .trace
        } else if line.hasPrefix("[DBG]") {
            self = .debug
        } else if line.hasPrefix("[INF]") {
            self = .info
        } else if line.hasPrefix("[WRN]") {
            self = .warning
        } else if line.hasPrefix("[ERR]") {
            self = .error
        } else if line.hasPrefix("[FTL]") {
            self = .fatal
        } else {
            self = .unknown
        }
    }
    
    func shortFormat(message: String) -> String {
        "\(rawValue):\(message)"
    }
}