//
//  MainPresenter.swift
//  Museum
//
//  Created by Vyacheslav on 29.01.2023.
//

import UIKit
import EventKit

protocol MainViewProtocol: AnyObject {
    func fillElements(email: String, event: Event)
    func setButtonPlanVisit(planVisitTitle: String)
    func setButtonWasPlanned(plannedVisitTitle: String)
    func disableButton(buttonTitle: String) 
}

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, jsonService: JsonServiceProtocol, router: RouterProtocol, email: String)
    func viewWasLoaded()
    func checkEvent()
    func logout()
    func planVisitTapped(sender: UIButton)
}

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    let jsonService: JsonServiceProtocol
    let router: RouterProtocol
    var email: String
    let event = Event(
        artMuseumTitle: String(localized: "main.screen.art.museum.title"),
        type: String(localized: "main.screen.type"),
        name: String(localized: "main.screen.name"),
        exactLocation: String(localized: "main.screen.exact.location"),
        address: String(localized: "main.screen.address"),
        workingHours: String(localized: "main.screen.working.hours"),
        planVisitTitle: String(localized: "main.screen.plan.visit.title"),
        plannedVisitTitle: String(localized: "main.screen.planned.visit.title")
    )
    
    required init(view: MainViewProtocol, jsonService: JsonServiceProtocol, router: RouterProtocol, email: String) {
        self.view = view
        self.jsonService = jsonService
        self.router = router
        self.email = email
    }
    
    enum Errors: LocalizedError {
        case calendarAccessDenied
        
        var errorDescription: String? {
            switch self {
            case .calendarAccessDenied:
                return "Calendar access denied by user"
            }
        }
    }
    
    func viewWasLoaded() {
        view?.fillElements(email: email, event: event)
    }
    
    func checkEvent() {
        Task {
            do {
                if try await eventAlreadyExists(
                    eventTitle: event.eventTitle,
                    startDate: event.startDate,
                    endDate: event.endDate
                ) {
                    // calendar event is already exist
                    await MainActor.run {
                        view?.setButtonWasPlanned(plannedVisitTitle: event.plannedVisitTitle)
                    }
                    return
                } else {
                    // calendar event is not exist
                    await MainActor.run {
                        view?.setButtonPlanVisit(planVisitTitle: event.planVisitTitle)
                    }
                    return
                }
            } catch {
                await MainActor.run {
                    view?.disableButton(buttonTitle: String(localized: "main.screen.error.calendar.access"))
                }
                debugPrint("Could not check calendar event. Error: \(error.localizedDescription)")
                return
            }
        }
    }
    
    // show view, than write to JSON
    func logout() {
        router.showLogInViewController(withAnimation: .fromLeft)
        let user = User.current
        user.erase()
        jsonService.write(dataObject: user)
    }
    
    // add/delete event to/from system calendar
    func planVisitTapped(sender: UIButton) {
        Task {
            do {
                let eventStore = EKEventStore()
                let requestResult: Bool = try await eventStore.requestAccess(to: .event)
                guard requestResult else {
                    throw Errors.calendarAccessDenied
                }
                
                if try await eventAlreadyExists(
                    eventTitle: event.eventTitle,
                    startDate: event.startDate,
                    endDate: event.endDate
                ) {
                    // delete all matching events
                    let predicate = eventStore.predicateForEvents(withStart: event.startDate, end: event.endDate, calendars: nil)
                    let existingEvents = eventStore.events(matching: predicate)
                    let filteredEvents = existingEvents.filter { existingEvent in
                        existingEvent.title == event.eventTitle &&
                        existingEvent.startDate == event.startDate &&
                        existingEvent.endDate == event.endDate
                    }
                    try filteredEvents.forEach { try eventStore.remove($0, span: .thisEvent) }
                    await MainActor.run {
                        view?.setButtonPlanVisit(planVisitTitle: event.planVisitTitle)
                    }
                } else {
                    // add event
                    let ekEvent = EKEvent(eventStore: eventStore)
                    let structuredLocation = EKStructuredLocation(title: event.eventLocationTitle)
                    ekEvent.title = event.eventTitle
                    ekEvent.structuredLocation = structuredLocation
                    ekEvent.notes = event.eventNotes
                    ekEvent.startDate = event.startDate
                    ekEvent.endDate = event.endDate
                    ekEvent.calendar = eventStore.defaultCalendarForNewEvents
                    try eventStore.save(ekEvent, span: .thisEvent)
                    await MainActor.run {
                        view?.setButtonWasPlanned(plannedVisitTitle: event.plannedVisitTitle)
                    }
                }
            } catch {
                debugPrint("Error: \(error.localizedDescription)")
                return
            }
        }
    }
    
    private func eventAlreadyExists(eventTitle: String, startDate: Date, endDate: Date) async throws -> Bool {
        let eventStore = EKEventStore()
        
        let requestResult = try await eventStore.requestAccess(to: .event)
        if requestResult == false {
            throw Errors.calendarAccessDenied
        }
        
        let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
        let existingEvents = eventStore.events(matching: predicate)
        
        let eventAlreadyExists = existingEvents.contains { event in
            event.title == eventTitle &&
            event.startDate == startDate &&
            event.endDate == endDate
        }
        return eventAlreadyExists
    }
}
