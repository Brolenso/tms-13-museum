import UIKit

extension UIButton {
    
    // MARK: Public Properties
    
    @IBInspectable
    var shadow: Bool {
        get {
            layer.shadowColor != .none ? true : false
        }
        set {
            if newValue {
                addShadow()
            } else {
                removeShadow()
            }
        }
    }
    
    
    // MARK: Public Methods
    
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        layer.shadowRadius = 4.0
    }
    
    func removeShadow() {
        layer.shadowColor = .none
        layer.shadowOpacity = 0.0
        layer.shadowOffset = .zero
        layer.shadowRadius = 0.0
    }
    
}
