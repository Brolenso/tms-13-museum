//
//  UIButton+shadow.swift
//  Museum
//
//  Created by Vyacheslav on 24.02.2023.
//

import UIKit

extension UIButton {
    
    // MARK: Constants
    
    private enum Constants {
        static let layerShadowColor = UIColor.black.cgColor
        static let layerShadowOpacity: Float = 0.25
        static let layerShadowOffset = CGSize(width: 0.0, height: 4.0)
        static let layerShadowRadius = 4.0
    }
    
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
        layer.shadowColor = Constants.layerShadowColor
        layer.shadowOpacity = Constants.layerShadowOpacity
        layer.shadowOffset = Constants.layerShadowOffset
        layer.shadowRadius = Constants.layerShadowRadius
    }
    
    func removeShadow() {
        layer.shadowColor = .none
        layer.shadowOpacity = .zero
        layer.shadowOffset = .zero
        layer.shadowRadius = .zero
    }
    
}
