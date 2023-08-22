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
        userProvider: UserRepositoryProtocol,
        eventProvider: EventRepositoryProtocol
    )
    func didLoad()
    func checkCalendarAccess()
    func addToCalendar()
    func removeFromCalendar()
    func logout()
}

final class EventPresenter: EventPresenterProtocol {

    // MARK: Constants

    private enum Constants {
        static let event = Event(
            galleryTitle: String(localized: "main.screen.art.museum.title"),
            type: String(localized: "main.screen.type"),
            name: String(localized: "main.screen.name"),
            exactLocation: String(localized: "main.screen.exact.location"),
            address: String(localized: "main.screen.address"),
            workingHours: String(localized: "main.screen.working.hours")
        )
    }

    // MARK: Private Properties

    private weak var view: EventViewProtocol?
    private let router: Routing
    private let user: User
    private let userProvider: UserRepositoryProtocol
    private let eventProvider: EventRepositoryProtocol
    private var event: Event?
    private var calendarAccessReceived: Bool? {
        didSet {
            changeButtonState()
        }
    }

    // MARK: Initialisers

    required init(
        view: EventViewProtocol,
        router: Routing,
        user: User,
        userProvider: UserRepositoryProtocol,
        eventProvider: EventRepositoryProtocol
    ) {
        self.view = view
        self.router = router
        self.user = user
        self.userProvider = userProvider
        self.eventProvider = eventProvider
    }

    // MARK: Public Methods

    func didLoad() {
        view?.fillUI()
        view?.fillUI(userName: user.email)

        event = Constants.event
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

    // MARK: Private Methods

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
