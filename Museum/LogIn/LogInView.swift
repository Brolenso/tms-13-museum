import UIKit

class LogInView: UIView {
    
    private let backgroundImage = UIImageView(frame: .zero)
    @IBOutlet var labelMuseum: UILabel!
    @IBOutlet var labelAdress: UILabel!
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
        backgroundImage.image = UIImage(named: "background")
        
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
        
        let textAdress = "3 Avenue Winston-Churchill\n75008 Paris, France"
        let attributedTextAdress = textAdress.setTextStyle(.subtitle)
        labelAdress.attributedText = attributedTextAdress
        
        let textLogIn = "Log In"
        let arrtibutedTextLogIn = textLogIn.setTextStyle(.button)
        buttonLogIn.setAttributedTitle(arrtibutedTextLogIn, for: .normal)
    }
    
}
