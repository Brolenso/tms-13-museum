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
        
        let textMuseum = NSAttributedString(string: "YOUR\nART\nMUSEUM", attributes: [
            .baselineOffset: 7.0,
        ])
        
        labelMuseum.attributedText = textMuseum
        
        let textAdress = NSAttributedString(string: "151 3rd St\nSan Francisco, CA 94103", attributes: [
            .baselineOffset: 4.0,
        ])
        
        labelAdress.attributedText = textAdress
        
        let textForgot = NSAttributedString(string: "Log In", attributes: [
            .font: UIFont(name: "Hiragino Sans", size: 12) ?? UIFont.systemFont(ofSize: 12),
        ])
        
        buttonLogIn.setAttributedTitle(textForgot, for: .normal)
        buttonLogIn.layer.shadowColor = UIColor.black.cgColor
        buttonLogIn.layer.shadowOpacity = 0.25
        buttonLogIn.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        buttonLogIn.layer.shadowRadius = 4.0
    }
    
}
