//
//  ViewController.swift
//  Museum
//
//  Created by Vyacheslav on 17.12.2022.
//

import UIKit

protocol LogInViewProtocol: AnyObject {

}

final class LogInViewController: UIViewController, LogInViewProtocol {

    // MARK: Constants

    private enum Constants {
        static let textMuseum = String(localized: "login.screen.museum.label.text")
        static let textAddress = String(localized: "login.screen.address.label.text")
        static let textLogIn = String(localized: "login.screen.login.button.title")
    }

    // MARK: IBOutlet

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var labelMuseum: UILabel!
    @IBOutlet var labelAddress: UILabel!
    @IBOutlet var emailTextField: MuseumTextField!
    @IBOutlet var passwordTextField: MuseumTextField!
    @IBOutlet var logInButton: UIButton!
    @IBOutlet var dontHaveAnAccount: MuseumLabel!

    // MARK: Public Properties

    var presenter: LogInPresenterProtocol?

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
        setupUiTexts()
    }

    // MARK: IBAction

    // option 2: target - action from storyboard
    @IBAction func passwordDonePressed(_ sender: MuseumTextField) {
        logIn()
    }

    @IBAction func logInTapped(_ sender: UIButton) {
        logIn()
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

    // MARK: Private Methods

    @objc
    private func emailDonePressed(_ sender: MuseumTextField) {
        logIn()
    }

    // old method before keyboardLayoutGuide in iOS 15.0+
    @objc
    private func keyboardWillChangeFrame(_ notification: NSNotification) {
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
        let attributedTextMuseum = Constants.textMuseum.uppercased().setTextStyle(.title)
        labelMuseum.attributedText = attributedTextMuseum

        let attributedTextAddress = Constants.textAddress.setTextStyle(.subtitle)
        labelAddress.attributedText = attributedTextAddress

        let attributedTextLogIn = Constants.textLogIn.setTextStyle(.button)
        logInButton.setAttributedTitle(attributedTextLogIn, for: .normal)
    }

    private func logIn() {
        let email = emailTextField.text
        let password = passwordTextField.text
        presenter?.loginUser(email: email, password: password)
    }

}
