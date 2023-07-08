//
//  ViewController.swift
//  Museum
//
//  Created by Vyacheslav on 17.12.2022.
//

import UIKit

final class LogInViewController: UIViewController, LogInViewProtocol {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var labelMuseum: UILabel!
    @IBOutlet var labelAddress: UILabel!
    @IBOutlet var emailTextField: LogInTextField!
    @IBOutlet var passwordTextField: LogInTextField!
    @IBOutlet var forgotPasswordLabel: LogInLabelTappable!
    @IBOutlet var logInButton: UIButton!
    @IBOutlet var dontHaveAnAccount: LogInLabelTappable!
    
    internal var presenter: LogInPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUiTexts()
        setupCustomTextfields()
        addTopSpace()
    }
    
    private func setupUiTexts() {
        let textMuseum = String(localized: "login.screen.museum.label.text")
        let attributedTextMuseum = textMuseum.uppercased().setTextStyle(.title)
        labelMuseum.attributedText = attributedTextMuseum
        
        let textAddress = String(localized: "login.screen.address.label.text")
        let attributedTextAddress = textAddress.setTextStyle(.subtitle)
        labelAddress.attributedText = attributedTextAddress
        
        let textLogIn = String(localized: "login.screen.login.button.title")
        let attributedTextLogIn = textLogIn.setTextStyle(.button)
        logInButton.setAttributedTitle(attributedTextLogIn, for: .normal)
    }
    
    private func setupCustomTextfields() {
        emailTextField.closureLogInTap = self.closureLogInTap
        passwordTextField.closureLogInTap = self.closureLogInTap
        
        emailTextField.keyboardType = .emailAddress
        
        // option 3: target - action from code
        emailTextField.addTarget(self, action: #selector(emailDonePressed(_:)), for: .editingDidEndOnExit)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChangeFrame(_:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    private func addTopSpace() {
        // add free space on top of content if possible
        let scrollLayoutGuide = UILayoutGuide()
        view.addLayoutGuide(scrollLayoutGuide)
        
        let constraintHeight = scrollLayoutGuide.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: 20.0)
        
        constraintHeight.priority = .defaultLow - 1
        
        NSLayoutConstraint.activate([
            scrollLayoutGuide.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            scrollLayoutGuide.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            constraintHeight,
        ])
    }
    
    // option 3: target - action from code
    @objc
    private func emailDonePressed(_ sender: LogInTextField) {
        logIn()
    }
    
    // option 2: target - action from storyboard
    @IBAction func passwordDonePressed(_ sender: LogInTextField) {
        logIn()
    }
    
    // option 1: login action to call from other class
    lazy var closureLogInTap = { [weak self] in
        guard let self else { return }
        self.logIn()
    }
    
    @IBAction func logInTapped(_ sender: UIButton) {
        logIn()
    }
    
    private func logIn() {
        let email = emailTextField.text
        let password = passwordTextField.text
        presenter?.loginUser(email: email, password: password)
    }

    @IBAction func forgotYourPasswordTapped(_ sender: UITapGestureRecognizer) {
        // fatalError("Crash to test Firebase Crashlytics")
    }
    
    @IBAction func dontHaveAnAccountTapped(_ sender: UITapGestureRecognizer) {
        // login functions are not implemented
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
        
        let visibleFrame: CGRect
        
        // in Landscape mode
        if UIDevice.current.orientation.isLandscape {
            visibleFrame = logInButton.frame.inset(by: UIEdgeInsets(top: 0.0,
                                                                    left: 0.0,
                                                                    bottom: 10.0,
                                                                    right: 0.0))
        } else {
            // in Portrait mode
            visibleFrame = dontHaveAnAccount.frame.inset(by: UIEdgeInsets(top: 0.0,
                                                                          left: 0.0,
                                                                          bottom: -10.0,
                                                                          right: 0.0))
        }
        
        scrollView.scrollRectToVisible(visibleFrame, animated: true)
    }
    
}
