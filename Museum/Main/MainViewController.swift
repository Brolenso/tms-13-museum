//
//  MainViewController.swift
//  Museum
//
//  Created by Vyacheslav on 12.01.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var labelEmail: UILabel!
    @IBOutlet var buttonLogOut: UIButton!
    @IBOutlet var topBlackView: UIView!
    
    
    var user: User

    init?(user: User, coder: NSCoder) {
        self.user = user
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        customiseTopBlackView()
        customiseLabelEmail()
        customiseButtonLogOut()
    }
    
    @IBAction func buttonLogOutTapped(_ sender: UIButton) {
        // show logInViewController screen:
        guard let logInNavigationController = (view.window?.windowScene?.delegate as? SceneDelegate)?.logInNavigationController else {
            return
        }
                
        let logInViewController = UIStoryboard(name: "LogInStoryboard", bundle: .main).instantiateViewController(withIdentifier: "logInScreen")

        logInNavigationController.setViewControllers([logInViewController], animated: true)
        
        user.erase()
        
        JsonData().user = user
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide navigationBar
        navigationController?.navigationBar.isHidden = true
    }
    
    private func customiseLabelEmail() {
        labelEmail.attributedText = user.email.uppercased().setTextStyle(.labelDark)
    }
    
    private func customiseButtonLogOut() {
        buttonLogOut.setAttributedTitle(("LOG\nOUT").setTextStyle(.labelDark), for: .normal)
    }
    
    private func customiseTopBlackView() {
        topBlackView.translatesAutoresizingMaskIntoConstraints = false
        
    }

}
