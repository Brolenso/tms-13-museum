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
    @IBOutlet var buttonLogOut: UIButton!
    @IBOutlet var buttonExhibition: UIButton!
    @IBOutlet var buttonHeader: UIButton!
    @IBOutlet var buttonDate: UIButton!
    @IBOutlet var buttonFloor: UIButton!
    @IBOutlet var buttonPlanVisit: UIButton!
    @IBOutlet var buttonAdressStreet: UIButton!
    @IBOutlet var buttonOpenToday: UIButton!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide navigationBar
        navigationController?.navigationBar.isHidden = true
    }
    
    private func customiseInterfaceElements() {
        buttonTheArtMuseum.setAttributedTitle(("THE\nART\nMUSEUM").setTextStyle(.labelDark), for: .normal)
        buttonLogOut.setAttributedTitle(("LOG\nOUT").setTextStyle(.labelDark), for: .normal)
        buttonExhibition.setAttributedTitle(("EXHIBITION").setTextStyle(.labelGrey), for: .normal)
        buttonHeader.setAttributedTitle(("MASTERS\nOLD AND\nNEW").setTextStyle(.header), for: .normal)
        buttonDate.setAttributedTitle(("APRIL 15 - SEPTEMBER 20").setTextStyle(.headerDate), for: .normal)
        buttonFloor.setAttributedTitle(("FLOOR 5").setTextStyle(.labelGrey), for: .normal)
        buttonPlanVisit.setAttributedTitle(("Plan Your Visit").setTextStyle(.button), for: .normal)
        buttonAdressStreet.setAttributedTitle(("3 Avenue Winston-Churchill\n75008 Paris, France").setTextStyle(.coordinates), for: .normal)
        buttonOpenToday.setAttributedTitle(("Open today\n10:00 – 17:00").setTextStyle(.coordinates), for: .normal)
    }
}

extension MainViewController: MainViewProtocol {
    func showEmail(email: String) {
        labelEmail.attributedText = email.uppercased().setTextStyle(.labelDark)
    }
}
