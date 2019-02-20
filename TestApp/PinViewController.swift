//
//  PinController.swift
//  TestApp
//
//  Created by Nermin Ramic on 14/02/2019.
//  Copyright © 2019 Nermin Ramic. All rights reserved.
//

import UIKit
import CoreData

class PinViewController: UIViewController, KeyboardDelegate {
    
    @IBOutlet weak var pinInput: UITextField!
    @IBOutlet weak var viewContainer: UIView!
    
    var parentController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pinInput.becomeFirstResponder()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)

        let keyboardView = Keyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 500))
        keyboardView.delegate = self
        
        pinInput.inputView = keyboardView
    }
    
    func keyWasTapped(character: String) {
        switch character {
        case "CANCEL":
            self.view.removeFromSuperview()
        case "DELETE":
            let newPin = String(((pinInput.text)?.dropLast())!)
            self.pinInput.text = newPin
        case "DONE":
            if validatePin() {
                if let parent = self.parentController as? RegisterViewController {
                    parent.pin = self.pinInput.text
                    parent.registerUser()
                } else if let parent = self.parentController as? LoginViewController {
                    parent.pin = self.pinInput.text
                    parent.loginUser()
                }
                
                self.view.removeFromSuperview()
            } else {
                self.showValidationError(alertMessage: "Pin must be between 4 and 6 characters.")
            }
        default:
            self.pinInput.insertText(character)
        }
    }
    
    fileprivate func validatePin() -> Bool {
        let pin:String = self.pinInput.text!
        
        return pin.count >= 4 && pin.count <= 6
    }
    
    fileprivate func showValidationError(alertMessage: String) {
        let alert = UIAlertController(title: "Error", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
