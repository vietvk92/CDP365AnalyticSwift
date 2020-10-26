//
//  ANLogger.swift
//  CDP365Analytic
//
//  Created by VietVK on 10/26/20.
//  Copyright © 2020 ANTSPROGRAMMATIC. All rights reserved.
//

import Foundation

struct ANLogger {

    /// The tag prefix each log entry will have.
    fileprivate static let Tag = "[CDP365AnalyticV1]"

    /// The log levels
    fileprivate enum Level: String {
        case Debug = "[DEBUG]"
        case Error = "[ERROR]"
    }

    /// Write the std using NSLOG.
    fileprivate static func log(_ level: Level, _ message: @autoclosure () -> String, _ error: Error? = nil) {
        if let nsError = error as NSError? {
            NSLog("%@%@ %@ with error %@", Tag, level.rawValue, message(), nsError)
        } else {
            NSLog("%@%@ %@", Tag, level.rawValue, message())
        }
    }

    /// Debug log method
    static func debug(_ message: @autoclosure () -> String, _ error: Error? = nil) {
        #if DEBUG
        log(.Debug, message(), error)
        #endif
    }

    /// Error log method
    static func error(_ message: @autoclosure () -> String, _ error: Error? = nil) {
        log(.Error, message(), error)
    }

    /// Error log method with Swift.Error type.
    static func error(_ error: Error? = nil) {
        log(.Error, "An error occured", error)
    }

}
