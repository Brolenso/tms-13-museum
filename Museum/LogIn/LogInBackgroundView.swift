import UIKit

class LogInBackgroundView: UIView {
    
    private let backgroundImage = UIImageView(frame: .zero)
    @IBOutlet var labelMuseum: UILabel!
    @IBOutlet var labelAddress: UILabel!
    @IBOutlet var buttonLogIn: UIButton!
    
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
        backgroundImage.image = UIImage(named: "Background")
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.contentMode = .scaleAspectFill
        self.addSubview(backgroundImage)

        NSLayoutConstraint.activate([
            backgroundImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 25.0),
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor, constant: -70.0),
            backgroundImage.leftAnchor.constraint(lessThanOrEqualTo: self.leftAnchor, constant: -20.0),
            backgroundImage.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: 30.0),
        ])
        
        let textMuseum = "GRAND\nPALAIS\nMUSEUM"
        let attributedTextMuseum = textMuseum.setTextStyle(.title)
        labelMuseum.attributedText = attributedTextMuseum
        
        let textAddress = "3 Avenue Winston-Churchill\n75008 Paris, France"
        let attributedTextAddress = textAddress.setTextStyle(.subtitle)
        labelAddress.attributedText = attributedTextAddress
        
        let textLogIn = "Log In"
        let attributedTextLogIn = textLogIn.setTextStyle(.button)
        buttonLogIn.setAttributedTitle(attributedTextLogIn, for: .normal)
    }
    
}
