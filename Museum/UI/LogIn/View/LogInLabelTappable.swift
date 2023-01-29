import UIKit

@IBDesignable
class LogInLabelTappable: UIView {
    
    private let label = UILabel(frame: .zero)
    
    @IBInspectable
    var text: String {
        get {
            label.text ?? ""
        }
        set {
            label.text = newValue
        }
    }
    
    @IBInspectable
    var rightTextAlignment: Bool {
        get {
            label.textAlignment == .right
        }
        set {
            if newValue == true {
                label.textAlignment = .right
            } else {
                label.textAlignment = .left
            }
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
        self.backgroundColor = nil
        
        let labelText = label.text ?? "Default label text"
        let attributedLabelText = labelText.setTextStyle(.label)
        label.attributedText = attributedLabelText
                
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
