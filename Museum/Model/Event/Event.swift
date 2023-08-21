//
//  Event.swift
//  Museum
//
//  Created by Vyacheslav on 22.02.2023.
//

import Foundation
import OSLog

struct Event {
    
    // MARK: Constants
    
    private enum Constants {
        static var currentDate: Date { Date() } // now
        static var tomorrowMidnight: Date? {
            let calendar = Calendar.current
            let todayMidnight = calendar.startOfDay(for: currentDate)
            return calendar.date(byAdding: .day, value: 1, to: todayMidnight)
        } // 0:00 tomorrow
        static let exhibitionBeginMonth = -1 // -1 month of current
        static let exhibitionEndMonth = 2 // +2 months to current
        static let durationBeginFormat = "MMMM 15" // "April 15 – "
        static let durationEndFormat = "MMMM 20" // " – August 20"
        static let calendarStartHours = 10 // at 10:00 tomorrow
        static let calendarFinishHours = 12 // at 12:00 tomorrow
    }
    
    private static let logger = Logger(subsystem: #file, category: "Event logger")
    
    // MARK: Public Properties
    
    let galleryTitle: String
    let type: String
    let name: String
    let exactLocation: String
    let address: String
    let workingHours: String
    
    var duration: String {
        var resultDate = ""
        let calendar = Calendar.current
        
        let dateExhibitionBegin = calendar.date(byAdding: .month, value: Constants.exhibitionBeginMonth, to: Constants.currentDate) ?? Constants.currentDate
        let dateExhibitionEnd = calendar.date(byAdding: .month, value: Constants.exhibitionEndMonth, to: Constants.currentDate) ?? Constants.currentDate
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.durationBeginFormat
        resultDate = dateFormatter.string(from: dateExhibitionBegin) + " – "
        dateFormatter.dateFormat = Constants.durationEndFormat
        resultDate += dateFormatter.string(from: dateExhibitionEnd)
        
        return resultDate
    }
    
    var title: String {
        ("\(type) \"\(name)\"").replacingOccurrences(of: "\n", with: " ")
    }
    
    var locationTitle: String {
        ("\(galleryTitle), \(address)").replacingOccurrences(of: "\n", with: " ")
    }
    
    var notes: String {
        ("\(workingHours.replacingOccurrences(of: "\n", with: " "))\n\(exactLocation.capitalized)")
    }
    
    var startDate: Date {
        guard let tomorrowMidnight = Constants.tomorrowMidnight,
              let startDate = Calendar.current.date(byAdding: .hour, value: Constants.calendarStartHours, to: tomorrowMidnight)
        else {
            return Date()
        }
        return startDate
    }
    
    var endDate: Date {
        guard let tomorrowMidnight = Constants.tomorrowMidnight,
              let endDate = Calendar.current.date(byAdding: .hour, value: Constants.calendarFinishHours, to: tomorrowMidnight)
        else {
            return Date()
        }
        return endDate
    }

}
