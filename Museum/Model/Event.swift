//
//  Event.swift
//  Museum
//
//  Created by Vyacheslav on 22.02.2023.
//

import Foundation

struct Event {
    let artMuseumTitle: String
    let type: String
    let name: String
    let exactLocation: String
    let address: String
    let workingHours: String
    let planVisitTitle: String
    let plannedVisitTitle: String
    
    let currentDate = Date()
    var eventDuration: String { // "April 15 – August 20"
        let calendar = Calendar.current
        let dateExhibitionBegin = calendar.date(byAdding: .month, value: -1, to: currentDate) ?? currentDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM 15"
        var resultDate = dateFormatter.string(from: dateExhibitionBegin) + " – "
        let dateExhibitionEnd = calendar.date(byAdding: .month, value: 2, to: currentDate) ?? currentDate
        dateFormatter.dateFormat = "MMMM 20"
        resultDate += dateFormatter.string(from: dateExhibitionEnd)
        return resultDate
    }
    var eventTitle: String {
        ("\(type) \"\(name)\"").replacingOccurrences(of: "\n", with: " ")
    }
    var eventLocationTitle: String {
        ("\(artMuseumTitle), \(address)").replacingOccurrences(of: "\n", with: " ")
    }
    var eventNotes: String {
        ("\(workingHours.replacingOccurrences(of: "\n", with: " "))\n\(exactLocation.capitalized)")
    }
    // tomorrow 10:00
    var startDate: Date {
        let calendar = Calendar.current
        var startDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd 10:00:00 ZZZZ"
        let startDateString = dateFormatter.string(from: startDate)
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss ZZZZ"
        startDate = dateFormatter.date(from: startDateString) ?? Date()
        return startDate
    }
    // tomorrow 12:00
    var endDate: Date {
        let calendar = Calendar.current
        var endDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd 12:00:00 ZZZZ"
        let endDateString = dateFormatter.string(from: endDate)
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss ZZZZ"
        endDate = dateFormatter.date(from: endDateString) ?? currentDate
        return endDate
    }
}
