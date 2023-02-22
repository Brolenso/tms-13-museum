//
//  MainPresenter.swift
//  Museum
//
//  Created by Vyacheslav on 29.01.2023.
//

import UIKit
import EventKit

protocol MainViewProtocol: AnyObject {
    func showEmail(email: String)
    func setButtonFulfilled(sender: UIButton) async
}

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, jsonService: JsonServiceProtocol, router: RouterProtocol, email: String)
    func setEmail()
    func logout()
    func planVisit(sender: UIButton,
                   artMuseumTitle: String,
                   exhibitionTitle: String,
                   headerTitle: String,
                   dateAppStart: Date,
                   floorTitle: String,
                   addressStreetTitle: String,
                   openTitle: String)
}

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    let jsonService: JsonServiceProtocol
    let router: RouterProtocol
    var email: String
    
    required init(view: MainViewProtocol, jsonService: JsonServiceProtocol, router: RouterProtocol, email: String) {
        self.view = view
        self.jsonService = jsonService
        self.router = router
        self.email = email
    }
    
    func setEmail() {
        view?.showEmail(email: email)
    }
    
    // show view, than write to JSON
    func logout() {
        router.showLogInViewController()
        let user = User.current
        user.erase()
        jsonService.write(dataObject: user)
    }
    
    // try to add an event to system calendar
    func planVisit(sender: UIButton,
                   artMuseumTitle: String,
                   exhibitionTitle: String,
                   headerTitle: String,
                   dateAppStart: Date,
                   floorTitle: String,
                   addressStreetTitle: String,
                   openTitle: String) {
        Task {
            let eventTitle = ("\(exhibitionTitle) \"\(headerTitle)\"").replacingOccurrences(of: "\n", with: " ")
            let eventLocationTitle = ("\(artMuseumTitle), \(addressStreetTitle)").replacingOccurrences(of: "\n", with: " ")
            let eventNotes = ("\(openTitle.replacingOccurrences(of: "\n", with: " "))\n\(floorTitle.capitalized)")
            
            // date, time - tomorrow from 10:00 to 12:00
            let calendar = Calendar.current
            var startDate = calendar.date(byAdding: .day, value: 1, to: dateAppStart) ?? Date()
            var endDate = calendar.date(byAdding: .day, value: 1, to: dateAppStart) ?? Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd 10:00:00 ZZZZ"
            let startDateString = dateFormatter.string(from: startDate)
            dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss ZZZZ"
            startDate = dateFormatter.date(from: startDateString) ?? Date()
            dateFormatter.dateFormat = "yyyy/MM/dd 12:00:00 ZZZZ"
            let endDateString = dateFormatter.string(from: endDate)
            dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss ZZZZ"
            endDate = dateFormatter.date(from: endDateString) ?? Date()
        
            do {
                let eventStore = EKEventStore()
                let requestResult: Bool = try await eventStore.requestAccess(to: .event)
                guard requestResult else {
                    throw Errors.calendarAccessDenied
                }
                
                let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
                let events = eventStore.events(matching: predicate)
                events.forEach { print($0) }
                
                let event = EKEvent(eventStore: eventStore)
                let structuredLocation = EKStructuredLocation(title: eventLocationTitle)
                event.title = eventTitle
                event.structuredLocation = structuredLocation
                event.notes = eventNotes
                event.startDate = startDate
                event.endDate = endDate
                event.calendar = eventStore.defaultCalendarForNewEvents
                try eventStore.save(event, span: .thisEvent)
                await view?.setButtonFulfilled(sender: sender)
            } catch {
                debugPrint("Couldn't not create a calendar event. Error: \(error.localizedDescription)")
                return
            }
        }
    }
}
