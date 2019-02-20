import UIKit

protocol KeyboardDelegate: class {
    func keyWasTapped(character: String)
}

class Keyboard: UIView {
    weak var delegate: KeyboardDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "Keyboard"
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
    
    @IBAction func keyTapped(_ sender: UIButton) {
        self.delegate?.keyWasTapped(character: sender.titleLabel!.text!)
    }
}
