//
//  Errors.swift
//  Museum
//
//  Created by Vyacheslav on 21.02.2023.
//

import Foundation

enum Errors: LocalizedError {
    case calendarAccessDenied
    
    var errorDescription: String? {
        switch self {
        case .calendarAccessDenied:
            return "Calendar access denied by user"
        }
    }
}
