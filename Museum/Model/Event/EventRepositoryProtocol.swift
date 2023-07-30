//
//  EventProvider.swift
//  Museum
//
//  Created by Vyacheslav on 11.07.2023.
//

import Foundation
import EventKit

protocol EventRepositoryProtocol {
    func requestCalendarAccess() async throws -> Bool
    func calendarContains(event: Event) -> Bool
    func addToCalendar(event: Event) throws
    func removeFromCalendar(event: Event) throws
}

class EventProvider: EventRepositoryProtocol {
    
    private let eventStore = EKEventStore()
    
    func requestCalendarAccess() async throws -> Bool {
        try await eventStore.requestAccess(to: .event)
    }
    
    func calendarContains(event: Event) -> Bool {
        let predicate = eventStore.predicateForEvents(withStart: event.startDate, end: event.endDate, calendars: nil)
        let existingEvents = eventStore.events(matching: predicate)
        
        return existingEvents.contains { existingEvent in
            existingEvent.title == event.title &&
            existingEvent.startDate == event.startDate &&
            existingEvent.endDate == event.endDate
        }
    }
    
    func addToCalendar(event: Event) throws {
        let ekEvent = EKEvent(eventStore: eventStore)
        let structuredLocation = EKStructuredLocation(title: event.locationTitle)
        ekEvent.title = event.title
        ekEvent.structuredLocation = structuredLocation
        ekEvent.notes = event.notes
        ekEvent.startDate = event.startDate
        ekEvent.endDate = event.endDate
        ekEvent.calendar = eventStore.defaultCalendarForNewEvents
        try eventStore.save(ekEvent, span: .thisEvent)
    }
    
    func removeFromCalendar(event: Event) throws {
        let predicate = eventStore.predicateForEvents(withStart: event.startDate, end: event.endDate, calendars: nil)
        let retrievedEvents = eventStore.events(matching: predicate)
        let matchingEvents = retrievedEvents.filter { retrievedEvent in
            retrievedEvent.title == event.title &&
            retrievedEvent.startDate == event.startDate &&
            retrievedEvent.endDate == event.endDate
        }
        try matchingEvents.forEach {
            try eventStore.remove($0, span: .thisEvent)
        }
    }

}
