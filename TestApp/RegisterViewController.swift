//
//  ViewController.swift
//  TestApp
//
//  Created by Nermin Ramic on 13/02/2019.
//  Copyright © 2019 Nermin Ramic. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    var user: User!
    var pin: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func register(_ sender: Any) {
        if self.validate() {
            self.showPinDialog()
        }
    }
    
    fileprivate func validate() -> Bool {
        let firstName = self.firstName.text
        let lastName = self.lastName.text
        
        if (firstName == "" || lastName == "") {
            self.showValidationError(alertMessage: "First and last name are required.")
            return false
        } else if (firstName!.count > 30 || lastName!.count > 30) {
            self.showValidationError(alertMessage: "First and last name must have less than 30 characters.")
            return false
        } else if (!(firstName!.isAlphanumeric()) || !(lastName!.isAlphanumeric())) {
            self.showValidationError(alertMessage: "First and last name must contain only letters and numbers.")
            return false
        }
        
        return true
    }
    
    fileprivate func showPinDialog() {
        let pinPopover = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pinController") as! PinViewController
        
        pinPopover.parentController = self
        self.addChild(pinPopover)
        pinPopover.view.frame = self.view.frame
        self.view.addSubview(pinPopover.view)
    }
    
    fileprivate func showValidationError(alertMessage: String) {
        let alert = UIAlertController(title: "Error", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func registerUser() {
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
        
        user.id = Int64(1)
        user.firstName = self.firstName.text
        user.lastName = self.lastName.text
        user.pin = Int16(self.pin)!
        
        appDelegate.saveContext()
        performSegue(withIdentifier: "showAccount", sender: self)
    }
}

extension String {
    func isAlphanumeric() -> Bool {
        return self.range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}
