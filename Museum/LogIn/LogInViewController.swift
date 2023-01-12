//
//  ViewController.swift
//  Museum
//
//  Created by Vyacheslav on 17.12.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var forgotPasswordLabel: LabelTappable!
    @IBOutlet var emailTextField: LogInTextField!
    @IBOutlet var passwordTextField: LogInTextField!
    @IBOutlet var logInButton: UIButton!
    
    // option 1: closure to tap button from other class
    lazy var closureLogInTap = { [weak self] in
        return self?.logIn() ?? ()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.closureLogInTap = self.closureLogInTap
        passwordTextField.closureLogInTap = self.closureLogInTap
        
        emailTextField.keyboardType = .emailAddress
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChangeFrame(_:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        
        // add free space on top of content if possible
        let scrollLayoutGuide = UILayoutGuide()
        view.addLayoutGuide(scrollLayoutGuide)
        
        let constraintHeight = scrollLayoutGuide.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: 47.0)

        constraintHeight.priority = .defaultLow - 1
        
        NSLayoutConstraint.activate([
            scrollLayoutGuide.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            scrollLayoutGuide.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            constraintHeight,
        ])
        
        // option 3: target - action from code
        emailTextField.addTarget(self, action: #selector(emailDonePressed(_:)), for: .editingDidEndOnExit)
        
        // try to filling textFields from JSON
        fillTextFieldsFromJson(emailToFill: emailTextField, passwordToFill: passwordTextField)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    // option 3: target - action from code
    @objc
    func emailDonePressed(_ sender: LogInTextField) {
        logIn()
    }
    
    // option 2: target - action from storyboard
    @IBAction func passwordDonePressed(_ sender: LogInTextField) {
        logIn()
    }
    
    @IBAction func logInTapped(_ sender: UIButton) {
        logIn()
    }
    
    @IBAction func forgotYourPasswordTapped(_ sender: UITapGestureRecognizer) {
    }
    
    @IBAction func dontHaveAnAccountTapped(_ sender: UITapGestureRecognizer) {
    }
    
    @IBAction func backgroundViewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(false)
    }
    
    @objc
    func keyboardWillChangeFrame(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        scrollView.contentInset = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: scrollView.frame.maxY - keyboardFrame.minY,
            right: 0.0
        )
        
        let visibleFrame = forgotPasswordLabel.frame.inset(by: UIEdgeInsets(top: 0.0,
                                                                            left: 0.0,
                                                                            bottom: -10.0,
                                                                            right: 0.0))
        
        scrollView.scrollRectToVisible(visibleFrame, animated: true)
    }
    
    private func logIn() {
        guard emailTextField.text.count > 0 else {
            return
        }
        
        // show next mainViewController screen
        if let mainViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateInitialViewController() {
            
            navigationController?.setViewControllers([mainViewController], animated: true)
        }

        // making object
        let user = User(email: emailTextField.text, password: passwordTextField.text)
        // writing data to JSON
        JsonData().user = user
    }
    
    private func fillTextFieldsFromJson(emailToFill: LogInTextField, passwordToFill: LogInTextField) {
        guard let user: User = JsonData().user else {
            print("Can not read User from JsonData().user")
            return
        }
        emailToFill.setTextFieldText(text: user.email)
        passwordToFill.setTextFieldText(text: user.password)
    }
}

