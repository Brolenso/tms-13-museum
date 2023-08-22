//
//  CATransition+animationType.swift
//  Museum
//
//  Created by Vyacheslav on 24.02.2023.
//

import UIKit

// making animations for use with setViewControllers
extension CATransition {

    // MARK: Public Properties

    static var fromLeft: CATransition {
        let caTransition = CATransition()
        caTransition.subtype = .fromLeft
        caTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        caTransition.type = CATransitionType.moveIn
        return caTransition
    }

    static var fromRight: CATransition {
        let caTransition = CATransition()
        caTransition.subtype = .fromRight
        caTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        caTransition.type = CATransitionType.moveIn
        return caTransition
    }

    static var systemDefault: CATransition {
        CATransition()
    }

}
