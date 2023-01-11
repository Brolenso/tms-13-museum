import UIKit

@IBDesignable
class LogInTextField: UIControl {

    // closure to tap button in other class
    public var closureLogInTap: () -> () = {  }
    
    private var textField = UITextField(frame: .zero)
        
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
    
    @IBInspectable
    var placeholder: String {
        get {
            return textField.placeholder ?? ""
        }
        set {
            textField.attributedPlaceholder = newValue.setTextStyle(.textfield)
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
    
    // runs when we create view by code: let myView = CustomView(frame: .zero)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    // runs if we placed view on storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // runs when view is loaded from storyboard
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        
        // functions are declared in extention to String
        textField.defaultTextAttributes[.font] = TextStyle.textfield.font
        textField.defaultTextAttributes[.foregroundColor] = TextStyle.textfield.color
        textField.defaultTextAttributes[.baselineOffset] = TextStyle.textfield.baselineOffset

        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 12.0),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        let tapGuesture = UITapGestureRecognizer(target: self,
                                                 action: #selector(textFieldViewTapped(_:)))
        self.addGestureRecognizer(tapGuesture)
        
        textField.delegate = self
    }
    
    @objc
    func textFieldViewTapped(_ sender: UITapGestureRecognizer) {
        textField.becomeFirstResponder()
    }
    
    // access to values by this interface
    public func setTextFieldText(text: String) {
        textField.text = text
    }
}

extension LogInTextField: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // calling tap to logInButton in LoginViewController class
        
        // option 1: closures
        closureLogInTap()
        
        // option 2: target - action
        sendActions(for: .editingDidEndOnExit)        

        // hide keyboard
        return textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // we will format only e-mail-type text fields
        guard textField.keyboardType == .emailAddress else {
            return true
        }
    
        // creating UITextRange from NSRange
        guard let startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location),
              let endPosition = textField.position(from: textField.beginningOfDocument, offset: range.location + range.length),
              let textRange = textField.textRange(from: startPosition, to: endPosition) else {
            return true
        }
        
        // deleting spaces by String extension
        let editedString = string.removeSpaces()
        
        // replacing text in changing range
        DispatchQueue.main.async {
            textField.replace(textRange, withText: editedString)
        }
        
        return false
    }
    
}
