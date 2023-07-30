import UIKit

@IBDesignable
final class MuseumTextField: UIControl {

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
        
    public var text: String {
        textField.text ?? ""
    }
    
    public var keyboardType: UIKeyboardType {
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
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                 action: #selector(textFieldViewTapped(_:)))
        self.addGestureRecognizer(tapGesture)
        
        textField.delegate = self
    }
    
    // access to values by this interface
    public func setTextFieldText(text: String) {
        textField.text = text
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
