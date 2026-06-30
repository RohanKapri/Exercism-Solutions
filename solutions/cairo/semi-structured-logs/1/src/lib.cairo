/// various log levels
#[derive(Drop, Clone, PartialEq, Debug)]
pub enum LogLevel {
    Info,
    Warning,
    Error,
    Debug,
}

/// primary function for emitting logs
pub fn log(level: LogLevel, message: ByteArray) -> ByteArray {
    match level {
        LogLevel::Info => format!("[INFO]: {}", message),
        LogLevel::Warning => format!("[WARNING]: {}", message),
        LogLevel::Error => format!("[ERROR]: {}", message),
        LogLevel::Debug => format!("[DEBUG]: {}", message),
    }
}

pub fn info(message: ByteArray) -> ByteArray {
    log(LogLevel::Info, message)
}

pub fn warn(message: ByteArray) -> ByteArray {
    log(LogLevel::Warning, message)
}

pub fn error(message: ByteArray) -> ByteArray {
    log(LogLevel::Error, message)
}