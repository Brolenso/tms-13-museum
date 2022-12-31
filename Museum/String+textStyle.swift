import UIKit

struct TextStyle {
    let size: Double
    let color: UIColor
    let fontName: String
    let baselineOffset: Double
    
    var font: UIFont {
        UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

extension TextStyle {
    
    static let title = TextStyle(
        size: 36.0,
        color: UIColor(named: "light-text") ?? UIColor.white,
        fontName: "Hiragino Sans",
        baselineOffset: 7.0
    )
    
    static let subtitle = TextStyle(
        size: 12.0,
        color: UIColor(named: "light-text") ?? UIColor.white,
        fontName: "Hiragino Sans",
        baselineOffset: 4.0
    )
    
    static let textfield = TextStyle(
        size: 12,
        color: .black,
        fontName: "Hiragino Sans",
        baselineOffset: 0.0
    )
   
    static let label = TextStyle(
        size: 10,
        color: UIColor(named: "light-text") ?? UIColor.white,
        fontName: "Hiragino Sans",
        baselineOffset: 0.0
    )
    
    static let button = TextStyle(
        size: 12,
        color: .white,
        fontName: "Hiragino Sans",
        baselineOffset: 0.0
    )
    
}

extension String {
    func setTextStyle(_ textStyle: TextStyle) -> NSAttributedString {
        let attributedString = NSAttributedString(
            string: self,
            attributes: [
                .font: textStyle.font,
                .foregroundColor: textStyle.color,
                .baselineOffset: textStyle.baselineOffset
            ]
        )
        return attributedString
    }
}
