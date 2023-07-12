//
//  EventPresenter.swift
//  Museum
//
//  Created by Vyacheslav on 29.01.2023.
//

import UIKit

protocol EventPresenterProtocol: AnyObject {
    init(
        view: EventViewProtocol,
        router: Routing,
        user: User,
        userProvider: UserProviding,
        eventProvider: EventProviding
    )
    func didLoad()
    func checkCalendarAccess()
    func addToCalendar()
    func removeFromCalendar()
    func logout()
}

final class EventPresenter: EventPresenterProtocol {
    
    private weak var view: EventViewProtocol?
    private let router: Routing
    private let user: User
    private let userProvider: UserProviding
    private let eventProvider: EventProviding
    private var event: Event?
    private var calendarAccessReceived: Bool? {
        didSet {
            changeButtonState()
        }
    }
    
    required init(
        view: EventViewProtocol,
        router: Routing,
        user: User,
        userProvider: UserProviding,
        eventProvider: EventProviding
    ) {
        self.view = view
        self.router = router
        self.user = user
        self.userProvider = userProvider
        self.eventProvider = eventProvider
    }

    func didLoad() {
        view?.fillUI()
        view?.fillUI(userName: user.email)
        
        event = getFakeEvent()
        if let event {
            view?.fillUI(event: event)
        }
    }
    
    func checkCalendarAccess() {
        Task {
            do {
                calendarAccessReceived = try await eventProvider.requestCalendarAccess()
            } catch {
                calendarAccessReceived = nil
                ErrorHandler.shared.logError(error)
                return
            }
        }
    }
    
    func addToCalendar() {
        guard let event else { return }
        do {
            try eventProvider.addToCalendar(event: event)
        } catch {
            ErrorHandler.shared.logError(error)
            return
        }
        changeButtonState()
    }
    
    func removeFromCalendar() {
        guard let event else { return }
        do {
            try eventProvider.removeFromCalendar(event: event)
        } catch {
            ErrorHandler.shared.logError(error)
            return
        }
        changeButtonState()
    }
    
    // show view, than write to JSON
    func logout() {
        userProvider.deleteUser()
        router.showLogInViewController(withAnimation: .fromLeft)
    }
    
    private func getFakeEvent() -> Event {
        Event(
            galleryTitle: String(localized: "main.screen.art.museum.title"),
            type: String(localized: "main.screen.type"),
            name: String(localized: "main.screen.name"),
            exactLocation: String(localized: "main.screen.exact.location"),
            address: String(localized: "main.screen.address"),
            workingHours: String(localized: "main.screen.working.hours")
        )
    }
    
    private func changeButtonState() {
        guard let event else { return }
        // run task on main actor
        Task { @MainActor in
            guard calendarAccessReceived == true else {
                view?.setButtonOff()
                return
            }
            
            if eventProvider.calendarContains(event: event) {
                view?.setButtonPlanned()
            } else {
                view?.setButtonPlan()
            }
        }
    }
    
}
