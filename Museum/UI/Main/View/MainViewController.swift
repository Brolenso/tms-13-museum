//
//  MainViewController.swift
//  Museum
//
//  Created by Vyacheslav on 12.01.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    let artMuseumTitle = "The\nArt\nMuseum"
    let logOutTitle = "Log\nout"
    let exhibitionTitle = "Exhibition"
    let headerTitle = "Masters\nold and\nnew"
    let dateAppStart = Date()
    var dateTitle: String { // "April 15 – August 20"
        let calendar = Calendar.current
        let dateExhibitionBegin = calendar.date(byAdding: .month, value: -1, to: dateAppStart) ?? Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM 15"
        var resultDate = dateFormatter.string(from: dateExhibitionBegin) + " – "
        let dateExhibitionEnd = calendar.date(byAdding: .month, value: 2, to: dateAppStart) ?? Date()
        dateFormatter.dateFormat = "MMMM 20"
        resultDate += dateFormatter.string(from: dateExhibitionEnd)
        return resultDate
    }
    let floorTitle = "floor 5"
    let planVisitTitle = "Plan Your Visit"
    let plannedVisitTitle = "Visit is in your calendar"
    let addressStreetTitle = "3 Avenue Winston-Churchill\n75008 Paris, France"
    let openTitle = "Open daily\n10:00 – 17:00"
    
    @IBOutlet var topBlackView: UIView!
    @IBOutlet var buttonTheArtMuseum: UIButton!
    @IBOutlet var labelEmail: UILabel!
    @IBOutlet var buttonLogOut: UIButton!
    @IBOutlet var buttonExhibition: UIButton!
    @IBOutlet var buttonHeader: UIButton!
    @IBOutlet var buttonDate: UIButton!
    @IBOutlet var buttonFloor: UIButton!
    @IBOutlet var buttonPlanVisit: UIButton!
    @IBOutlet var buttonAddressStreet: UIButton!
    @IBOutlet var buttonOpen: UIButton!
    
    var presenter: MainPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        customiseInterfaceElements()
        presenter.setEmail()
    }
    
    @IBAction func buttonLogOutTapped(_ sender: UIButton) {
        presenter.logout()
    }
    
    @IBAction func buttonPlanVisitTapped(_ sender: UIButton) {
        presenter.planVisit(sender: sender,
                            artMuseumTitle: artMuseumTitle,
                            exhibitionTitle: exhibitionTitle,
                            headerTitle: headerTitle,
                            dateAppStart: dateAppStart,
                            floorTitle: floorTitle,
                            addressStreetTitle: addressStreetTitle,
                            openTitle: openTitle)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide navigationBar
        navigationController?.navigationBar.isHidden = true
    }
    
    private func customiseInterfaceElements() {
        buttonTheArtMuseum.setAttributedTitle(artMuseumTitle.uppercased().setTextStyle(.labelDark), for: .normal)
        buttonLogOut.setAttributedTitle(logOutTitle.uppercased().setTextStyle(.labelDark), for: .normal)
        buttonExhibition.setAttributedTitle(exhibitionTitle.uppercased().setTextStyle(.labelGrey), for: .normal)
        buttonHeader.setAttributedTitle(headerTitle.uppercased().setTextStyle(.header), for: .normal)
        buttonDate.setAttributedTitle(dateTitle.uppercased().setTextStyle(.headerDate), for: .normal)
        buttonFloor.setAttributedTitle(floorTitle.uppercased().setTextStyle(.labelGrey), for: .normal)
        buttonPlanVisit.setAttributedTitle(planVisitTitle.setTextStyle(.button), for: .normal)
        buttonAddressStreet.setAttributedTitle(addressStreetTitle.setTextStyle(.coordinates), for: .normal)
        buttonOpen.setAttributedTitle(openTitle.setTextStyle(.coordinates), for: .normal)
    }
}

extension MainViewController: MainViewProtocol {
    func showEmail(email: String) {
        labelEmail.attributedText = email.uppercased().setTextStyle(.labelDark)
    }
    
    func setButtonFulfilled(sender: UIButton) async {
        sender.setAttributedTitle(plannedVisitTitle.setTextStyle(.button), for: .disabled)
        sender.backgroundColor = UIColor(named: "grey") ?? .gray
        sender.isEnabled = false
    }
}
