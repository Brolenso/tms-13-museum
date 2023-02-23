//
//  MainViewController.swift
//  Museum
//
//  Created by Vyacheslav on 12.01.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var topBlackView: UIView!
    @IBOutlet var buttonTheArtMuseum: UIButton!
    @IBOutlet var labelEmail: UILabel!
    @IBOutlet var buttonEventType: UIButton!
    @IBOutlet var buttonEventName: UIButton!
    @IBOutlet var buttonDate: UIButton!
    @IBOutlet var buttonExactLocation: UIButton!
    @IBOutlet var buttonPlanVisit: UIButton!
    @IBOutlet var buttonAddress: UIButton!
    @IBOutlet var buttonWorkingHours: UIButton!
    
    var presenter: MainPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewWasLoaded()
        
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { [weak self] _ in
            self?.presenter.checkEvent()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.checkEvent()
    }

    @IBAction func buttonLogOutTapped(_ sender: UIButton) {
        presenter.logout()
    }
    
    @IBAction func buttonPlanVisitTapped(_ sender: UIButton) {
        presenter.planVisitTapped(sender: sender)
    }
}

extension MainViewController: MainViewProtocol {
    
    func fillElements(email: String, event: Event) {
        labelEmail.attributedText = email.uppercased().setTextStyle(.labelDark)
        buttonTheArtMuseum.setAttributedTitle(event.artMuseumTitle.uppercased().setTextStyle(.labelDark), for: .normal)
        buttonEventType.setAttributedTitle(event.type.uppercased().setTextStyle(.labelGrey), for: .normal)
        buttonEventName.setAttributedTitle(event.name.uppercased().setTextStyle(.header), for: .normal)
        buttonDate.setAttributedTitle(event.eventDuration.uppercased().setTextStyle(.headerDate), for: .normal)
        buttonExactLocation.setAttributedTitle(event.exactLocation.uppercased().setTextStyle(.labelGrey), for: .normal)
        buttonPlanVisit.setAttributedTitle(event.planVisitTitle.setTextStyle(.button), for: .normal)
        buttonAddress.setAttributedTitle(event.address.setTextStyle(.coordinates), for: .normal)
        buttonWorkingHours.setAttributedTitle(event.workingHours.setTextStyle(.coordinates), for: .normal)
    }
    
    func setButtonWasPlanned(plannedVisitTitle: String) async {
        buttonPlanVisit.setAttributedTitle(plannedVisitTitle.setTextStyle(.button), for: .normal)
        buttonPlanVisit.backgroundColor = UIColor(named: "grey") ?? .gray
        buttonPlanVisit.isEnabled = true
        buttonPlanVisit.isHighlighted = true

    }
   
    func setButtonPlanVisit(planVisitTitle: String) async {
        buttonPlanVisit.setAttributedTitle(planVisitTitle.setTextStyle(.button), for: .normal)
        buttonPlanVisit.backgroundColor = UIColor(named: "grey") ?? .red
        buttonPlanVisit.isEnabled = true
        buttonPlanVisit.isHighlighted = false
    }
    
    func disableButton(buttonTitle: String) async {
        buttonPlanVisit.setAttributedTitle(buttonTitle.setTextStyle(.button), for: .disabled)
        buttonPlanVisit.backgroundColor = UIColor(named: "grey") ?? .gray
        buttonPlanVisit.isEnabled = false
        buttonPlanVisit.isHighlighted = false
    }

}
