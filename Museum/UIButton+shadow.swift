import UIKit

extension UIButton {
    
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
    
    public func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        layer.shadowRadius = 4.0
    }
    
    public func removeShadow() {
        layer.shadowColor = .none
        layer.shadowOpacity = 0.0
        layer.shadowOffset = .zero
        layer.shadowRadius = 0.0
    }
}
