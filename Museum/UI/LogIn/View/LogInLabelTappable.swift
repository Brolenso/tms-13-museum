import UIKit

@IBDesignable
final class LogInLabelTappable: UIView {
    
    private let label = UILabel(frame: .zero)
    private var rightAlignment: Bool = false
    
    @IBInspectable
    var localizedText: String {
        get {
            label.text ?? ""
        }
        set {
            label.text = NSLocalizedString(newValue, comment: "")
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
            rightAlignment = newValue
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
        
        // needs because NSLocalizedString break a storyboard defined alignment
        if rightAlignment {
            label.textAlignment = .right
        }
                
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
