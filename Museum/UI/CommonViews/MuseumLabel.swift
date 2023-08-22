//
//  MuseumLabel.swift
//  Museum
//
//  Created by Vyacheslav on 17.12.2022.
//

import UIKit

@IBDesignable
final class MuseumLabel: UIView {

    // MARK: Public Properties

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
            label.textAlignment = newValue ? .right : .left
        }
    }

    // MARK: Private Properties

    private let label = UILabel(frame: .zero)
    private var rightAlignment: Bool = false

    // MARK: Initialisers

    // runs when we create view by code
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    // runs if we place view on storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupView()
    }

    // MARK: Private Methods

    private func setupView() {
        let labelText = label.text ?? "Default text"
        label.attributedText = labelText.setTextStyle(.label)

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
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
