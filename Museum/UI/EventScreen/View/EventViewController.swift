//
//  EventViewController.swift
//  Museum
//
//  Created by Vyacheslav on 12.01.2023.
//

import UIKit

protocol EventViewProtocol: AnyObject {
    func fillUI()
    func fillUI(event: Event)
    func fillUI(userName: String)
    func setButtonPlan()
    func setButtonPlanned()
    func setButtonOff()
}

final class EventViewController: UIViewController {
    
    // MARK: Constants
    
    private let museumTitle = String(localized: "main.screen.art.museum.title")
    private let logoutTitle = String(localized: "main.screen.log.out")
    private let disabledButtonTitle = String(localized: "main.screen.error.calendar.access")
    private let planVisitTitle = String(localized: "main.screen.plan.visit.title")
    private let plannedVisitTitle = String(localized: "main.screen.planned.visit.title")
    
    
    // MARK: IBOutlet
    
    @IBOutlet var buttonTheArtMuseum: UIButton!
    @IBOutlet var labelEmail: UILabel!
    @IBOutlet var buttonLogOut: UIButton!
    @IBOutlet var buttonEventType: UIButton!
    @IBOutlet var buttonEventName: UIButton!
    @IBOutlet var buttonDate: UIButton!
    @IBOutlet var buttonExactLocation: UIButton!
    @IBOutlet var buttonPlanVisit: UIButton!
    @IBOutlet var buttonAddress: UIButton!
    @IBOutlet var buttonWorkingHours: UIButton!
    
    
    // MARK: Public Properties
    
    var presenter: EventPresenterProtocol?
    
    
    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.didLoad()
        
        // check calendar event on scene didBecomeActive
        NotificationCenter.default.addObserver(forName: UIScene.didActivateNotification, object: nil, queue: nil) { [weak self] _ in
            guard let self else { return }
            presenter?.checkCalendarAccess()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.checkCalendarAccess()
    }
    
    
    // MARK: IBAction

    @IBAction func buttonLogOutTapped(_ sender: UIButton) {
        presenter?.logout()
    }
    
}


// MARK: - EventViewProtocol

extension EventViewController: EventViewProtocol {
    
    func fillUI() {
        buttonTheArtMuseum.setAttributedTitle(
            museumTitle.uppercased().setTextStyle(.labelDark),
            for: .normal
        )
        
        buttonLogOut.setAttributedTitle(
            logoutTitle.uppercased().setTextStyle(.labelDarkRight),
            for: .normal
        )
    }
    
    func fillUI(userName: String) {
        labelEmail.attributedText = userName.uppercased().setTextStyle(.labelDark)
    }
    
    func fillUI(event: Event) {
        buttonEventType.setAttributedTitle(
            event.type.uppercased().setTextStyle(.labelGrey),
            for: .normal
        )

        buttonEventName.setAttributedTitle(
            event.name.uppercased().setTextStyle(.header),
            for: .normal
        )

        buttonDate.setAttributedTitle(
            event.duration.uppercased().setTextStyle(.headerDate),
            for: .normal
        )

        buttonExactLocation.setAttributedTitle(
            event.exactLocation.uppercased().setTextStyle(.labelGrey),
            for: .normal
        )

        buttonPlanVisit.backgroundColor = UIColor(named: "grey") ?? .gray
        buttonPlanVisit.setAttributedTitle(
            planVisitTitle.setTextStyle(.button),
            for: .normal
        )

        buttonAddress.setAttributedTitle(
            event.address.setTextStyle(.coordinates),
            for: .normal
        )

        buttonWorkingHours.setAttributedTitle(
            event.workingHours.setTextStyle(.coordinates),
            for: .normal
        )
    }
    
    func setButtonOff() {
        buttonPlanVisit.setAttributedTitle(disabledButtonTitle.setTextStyle(.button), for: .disabled)
        buttonPlanVisit.isEnabled = false
        buttonPlanVisit.isHighlighted = false
    }
    
    func setButtonPlanned() {
        buttonPlanVisit.setAttributedTitle(plannedVisitTitle.setTextStyle(.button), for: .normal)
        buttonPlanVisit.isEnabled = true
        buttonPlanVisit.isHighlighted = true
        buttonPlanVisit.removeTarget(nil, action: nil, for: .allEvents)
        buttonPlanVisit.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            presenter?.removeFromCalendar()
        }), for: .primaryActionTriggered)
    }
   
    func setButtonPlan() {
        buttonPlanVisit.setAttributedTitle(planVisitTitle.setTextStyle(.button), for: .normal)
        buttonPlanVisit.isEnabled = true
        buttonPlanVisit.isHighlighted = false
        buttonPlanVisit.removeTarget(nil, action: nil, for: .allEvents)
        buttonPlanVisit.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            presenter?.addToCalendar()
        }), for: .primaryActionTriggered)
    }

}
