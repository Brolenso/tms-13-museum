//
//  EventPresenter.swift
//  Museum
//
//  Created by Vyacheslav on 29.01.2023.
//

import UIKit
import EventKit

protocol EventViewProtocol: AnyObject {
    func fillElements(email: String, event: Event)
    func setButtonPlanVisit(planVisitTitle: String)
    func setButtonWasPlanned(plannedVisitTitle: String)
    func disableButton(buttonTitle: String.LocalizationValue) 
}

protocol EventPresenterProtocol: AnyObject {
    init(view: EventViewProtocol, userProvider: any UserProviding, router: Routing, user: User)
    func viewWasLoaded()
    func checkEvent()
    func logout()
    func planVisitTapped(sender: UIButton)
}

final class EventPresenter: EventPresenterProtocol {
    
    private weak var view: EventViewProtocol?
    private let userProvider: any UserProviding
    private let router: Routing
    private let user: User
    private let event = Event(
        artMuseumTitle: String(localized: "main.screen.art.museum.title"),
        type: String(localized: "main.screen.type"),
        name: String(localized: "main.screen.name"),
        exactLocation: String(localized: "main.screen.exact.location"),
        address: String(localized: "main.screen.address"),
        workingHours: String(localized: "main.screen.working.hours"),
        planVisitTitle: String(localized: "main.screen.plan.visit.title"),
        plannedVisitTitle: String(localized: "main.screen.planned.visit.title")
    )
    
    required init(view: EventViewProtocol, userProvider: any UserProviding, router: Routing, user: User) {
        self.view = view
        self.userProvider = userProvider
        self.router = router
        self.user = user
    }
    
    private enum Errors: LocalizedError {
        case calendarAccessDenied
        
        var errorDescription: String? {
            switch self {
            case .calendarAccessDenied:
                return "Calendar access denied by user"
            }
        }
    }
    
    func viewWasLoaded() {
        view?.fillElements(email: user.email, event: event)
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
                    view?.disableButton(buttonTitle: "main.screen.error.calendar.access")
                }
                ErrorHandler.shared.logError(error)
                return
            }
        }
    }
    
    // show view, than write to JSON
    func logout() {
        userProvider.deleteUser()
        router.showLogInViewController(withAnimation: .fromLeft)
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
                ErrorHandler.shared.logError(error)
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
