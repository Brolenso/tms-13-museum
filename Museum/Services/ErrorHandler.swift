//
//  ErrorHandler.swift
//  Museum
//
//  Created by Vyacheslav on 08.07.2023.
//

import Foundation
import OSLog

class ErrorHandler: LocalizedError {
    
    static let shared = ErrorHandler()
    
    private let logger = Logger(subsystem: #file, category: "Error logger")
    
    private init() {
    }
    
    func logError(_ error: Error) {
        logger.error("\(error.localizedDescription, privacy: .auto)")
    }
    
}
