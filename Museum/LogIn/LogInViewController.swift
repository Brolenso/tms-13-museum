//
//  ViewController.swift
//  Museum
//
//  Created by Vyacheslav on 17.12.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var forgotPasswordLabel: LableTapable!
    @IBOutlet var emailTextField: LogInTextField!
    @IBOutlet var passwordTextField: LogInTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChangeFrame(_:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        
        let scrollLayoutGuide = UILayoutGuide()
        view.addLayoutGuide(scrollLayoutGuide)
        
        let constraint = scrollLayoutGuide.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        constraint.priority = .defaultLow - 1
        NSLayoutConstraint.activate([
            scrollLayoutGuide.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            scrollLayoutGuide.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            constraint,
        ])
        
        emailTextField.keyboardType = .emailAddress
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    @IBAction func logInTapped(_ sender: UIButton) {
        print(emailTextField.text)
        print(passwordTextField.text)
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
}

