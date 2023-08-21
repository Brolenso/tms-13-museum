//
//  String+textStyle.swift
//  Museum
//
//  Created by Vyacheslav on 24.02.2023.
//

import UIKit
import OSLog

extension String {
    
    // MARK: Public Methods
    
    func setTextStyle(_ textStyle: TextStyle) -> NSAttributedString {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textStyle.alignment
        
        let attributedString = NSAttributedString(
            string: self,
            attributes: [
                .font: textStyle.font,
                .foregroundColor: textStyle.color,
                .paragraphStyle : paragraphStyle,
            ]
        )
        return attributedString
    }
    
}

struct TextStyle {
    
    // MARK: Constants
    
    private static let logger = Logger(subsystem: #file, category: "Text style logger")
    
    // MARK: Public Properties
    
    let size: Double
    let color: UIColor
    let fontName: String
    var alignment: NSTextAlignment = .left
    
    var font: UIFont {
        guard let font = UIFont(name: fontName, size: size) else {
            Self.logger.warning("Font \(fontName) not found")
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
    
}


// MARK: Public Properties

extension TextStyle {
    
    static let title = TextStyle(
        size: 36.0,
        color: UIColor(named: "light-text") ?? .white,
        fontName: "Montserrat-Regular"
    )
    static let header = TextStyle(
        size: 24.0,
        color: .black,
        fontName: "Montserrat-Regular"
    )
    static let headerDate = TextStyle(
        size: 18.0,
        color: UIColor(named: "red") ?? .red,
        fontName: "Montserrat-Regular"
    )
    static let subtitle = TextStyle(
        size: 12.0,
        color: UIColor(named: "light-text") ?? .white,
        fontName: "Montserrat-Regular"
    )
    static let textfield = TextStyle(
        size: 12.0,
        color: .black,
        fontName: "Montserrat-Regular"
    )
    static let button = TextStyle(
        size: 12.0,
        color: .white,
        fontName: "Montserrat-Regular"
    )
    static let coordinates = TextStyle(
        size: 12.0,
        color: UIColor(named: "red") ?? .red,
        fontName: "Montserrat-Regular"
    )
    static let label = TextStyle(
        size: 10.0,
        color: UIColor(named: "light-text") ?? .white,
        fontName: "Montserrat-Regular"
    )
    static let labelDark = TextStyle(
        size: 10.0,
        color: .black,
        fontName: "Montserrat-Regular"
    )
    static let labelDarkRight = TextStyle(
        size: 10.0,
        color: .black,
        fontName: "Montserrat-Regular",
        alignment: .right
    )
    static let labelGrey = TextStyle(
        size: 10.0,
        color: UIColor(named: "grey") ?? .gray,
        fontName: "Montserrat-Regular"
    )
    
}
