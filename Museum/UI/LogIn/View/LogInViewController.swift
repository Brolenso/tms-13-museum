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
    @IBOutlet var emailTextField: MuseumTextField!
    @IBOutlet var passwordTextField: MuseumTextField!
    @IBOutlet var logInButton: UIButton!
    @IBOutlet var dontHaveAnAccount: LogInLabelTappable!
    
    internal var presenter: LogInPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        setupUiTexts()
    }
    
    private func setupViewController() {
        emailTextField.keyboardType = .emailAddress
        
        // option 1: target - action from code
        emailTextField.addTarget(self, action: #selector(emailDonePressed(_:)), for: .editingDidEndOnExit)
        
        // keyboard will change frame notification
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChangeFrame(_:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
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
    
    // option 1: target - action from code
    @objc
    private func emailDonePressed(_ sender: MuseumTextField) {
        logIn()
    }
    
    // option 2: target - action from storyboard
    @IBAction func passwordDonePressed(_ sender: MuseumTextField) {
        logIn()
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
    
    // old method before keyboardLayoutGuide in iOS 15.0+
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
