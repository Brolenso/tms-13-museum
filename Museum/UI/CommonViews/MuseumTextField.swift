//
//  MuseumTextField.swift
//  Museum
//
//  Created by Vyacheslav on 17.12.2022.
//

import UIKit

@IBDesignable
final class MuseumTextField: UIControl {

    // MARK: Constants

    private enum Constants {
        static let textFieldLeadingAnchor = 15.0
        static let textFieldTrailingAnchor = -15.0
    }

    // MARK: Public Properties

    @IBInspectable
    var localizedPlaceholder: String {
        get {
            textField.placeholder ?? ""
        }
        set {
            return textField.attributedPlaceholder = NSLocalizedString(newValue, comment: "").setTextStyle(.textfield)
        }
    }

    @IBInspectable
    var securityEntry: Bool {
        get {
            textField.isSecureTextEntry
        }
        set {
            textField.isSecureTextEntry = newValue
        }
    }

    var text: String {
        textField.text ?? ""
    }

    var keyboardType: UIKeyboardType {
        get {
            textField.keyboardType
        }
        set {
            textField.keyboardType = newValue
        }
    }

    // MARK: Private Properties

    private var textField = UITextField(frame: .zero)

    // MARK: Initialisers

    // runs when we create view by code
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    // runs if we place view on storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupView()
    }

    // MARK: Public Methods

    // set values by this interface
    func setTextFieldText(text: String) {
        textField.text = text
    }

    // MARK: Private Methods

    @objc
    private func textFieldViewTapped(_ sender: UITapGestureRecognizer) {
        textField.becomeFirstResponder()
    }

    private func setupView() {
        self.backgroundColor = .white

        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no

        // functions are declared in extension to String
        textField.defaultTextAttributes[.font] = TextStyle.textfield.font
        textField.defaultTextAttributes[.foregroundColor] = TextStyle.textfield.color

        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textField)

        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.textFieldLeadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.textFieldTrailingAnchor),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(textFieldViewTapped)
        )
        self.addGestureRecognizer(tapGesture)

        textField.delegate = self
    }

}

// MARK: - UITextFieldDelegate

extension MuseumTextField: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // option 1, 2: sending action to target - action subscribers
        sendActions(for: .editingDidEndOnExit)

        // call resignFirstResponder and hide keyboard
        return textField.resignFirstResponder()
    }

}
