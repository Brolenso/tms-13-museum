//
//  MainViewController.swift
//  Museum
//
//  Created by Vyacheslav on 12.01.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var labelEmail: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        customiseLabelEmail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide navigationBar
        navigationController?.navigationBar.isHidden = true
    }
    
    private func customiseLabelEmail() {
        
        guard let user = JsonData().user else {
            print("Can not customise labelEmail")
            return
        }
                
        labelEmail.attributedText = user.email.uppercased().setTextStyle(.labelDark)
    }

}
