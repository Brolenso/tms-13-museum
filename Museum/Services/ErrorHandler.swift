//
//  ErrorHandler.swift
//  Museum
//
//  Created by Vyacheslav on 08.07.2023.
//

import Foundation
import OSLog

class ErrorHandler: LocalizedError {

    // MARK: Public Properties

    static let shared = ErrorHandler()

    // MARK: Private Properties

    private let logger = Logger(subsystem: #file, category: "Error logger")

    // MARK: Initialisers

    private init() {
    }

    // MARK: Public Methods

    func logError(_ error: Error) {
        logger.error("\(error.localizedDescription, privacy: .auto)")
    }

}
