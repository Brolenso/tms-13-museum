import UIKit

@IBDesignable
class LableTapable: UIView {
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
        
        let attributedText = NSAttributedString(string: label.text ?? "Default label text", attributes: [
            .foregroundColor: UIColor(named: "light-text") ?? UIColor.white,
            .font: UIFont(name: "Hiragino Sans", size: 10) ?? UIFont.systemFont(ofSize: 10),
        ])
        label.attributedText = attributedText
                
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
