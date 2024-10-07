//
//  HCLogger.swift
//  HCScaffold
//
//  Created by oneko on 10/8/24.
//

import Foundation

// 定义日志级别
public enum LogLevel: Int {
    case debug = 0
    case info
    case warning
    case error

    var description: String {
        switch self {
        case .debug: return "DEBUG"
        case .info: return "INFO"
        case .warning: return "WARNING"
        case .error: return "ERROR"
        }
    }
}

// 日志系统类
public class HCLogger {

    // 当前日志级别，只有级别高于或等于此值的日志才会被打印
    public var logLevel: LogLevel = .debug
    private(set) var logToFile: Bool = false
    private let logFileURL: URL?

    public init(logToFile: Bool = false) {
        self.logToFile = logToFile
        if logToFile {
            let fileManager = FileManager.default
            let logDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            let logFile = logDirectory.appendingPathComponent("app.log")
            self.logFileURL = logFile

            // 创建日志文件
            if !fileManager.fileExists(atPath: logFile.path) {
                fileManager.createFile(atPath: logFile.path, contents: nil, attributes: nil)
            }
        } else {
            self.logFileURL = nil
        }
    }

    // 打印日志，增加文件名、行号、列号和函数名
    func log(_ message: String, level: LogLevel, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
        guard level.rawValue >= logLevel.rawValue else { return }
        
        let timestamp = formatDate(Date())
        let filename = (file as NSString).lastPathComponent
        let formattedMessage = "[\(timestamp)] [\(level.description)] [\(filename):\(line):\(column)] [\(function)] - \(message)"

        // 打印到控制台
        print(formattedMessage)

        // 如果需要输出到文件
        if logToFile, let logFileURL = logFileURL {
            appendToFile(formattedMessage + "\n", fileURL: logFileURL)
        }
    }

    // 格式化日期
    var formatter: DateFormatter!
    private func formatDate(_ date: Date) -> String {
        if formatter == nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS" // 增加 SSS 表示毫秒
            formatter = dateFormatter
        }
        return formatter.string(from: date)
    }

    // 写入日志到文件
    private func appendToFile(_ text: String, fileURL: URL) {
        if let fileHandle = try? FileHandle(forWritingTo: fileURL) {
            fileHandle.seekToEndOfFile()
            if let data = text.data(using: .utf8) {
                fileHandle.write(data)
            }
            fileHandle.closeFile()
        }
    }

    // 便捷方法
    public func debug(_ message: String, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
        log(message, level: .debug, file: file, line: line, column: column, function: function)
    }

    public func info(_ message: String, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
        log(message, level: .info, file: file, line: line, column: column, function: function)
    }

    public func warning(_ message: String, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
        log(message, level: .warning, file: file, line: line, column: column, function: function)
    }

    public func error(_ message: String, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
        log(message, level: .error, file: file, line: line, column: column, function: function)
    }
}

//let logger = HCLogger(logToFile: true) // 日志写入文件
//
//logger.logLevel = .info // 设置最低日志级别为 info
//
//// 打印日志
//logger.debug("This is a debug message")     // 不会输出，因为日志级别是 info
//logger.info("This is an info message")      // 会输出，并带有文件名、行号、列号、函数名
//logger.warning("This is a warning message") // 会输出
//logger.error("This is an error message")    // 会输出
