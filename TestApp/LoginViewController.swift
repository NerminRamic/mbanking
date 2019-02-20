//
//  LoginViewController.swift
//  TestApp
//
//  Created by Nermin Ramic on 18/02/2019.
//  Copyright © 2019 Nermin Ramic. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var userLabel: UILabel!
    
    var user: User!
    var pin: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchUser()
        self.setUserLabel()
    }
    
    fileprivate func fetchUser() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate(format: "id = %@", "1")
        request.returnsObjectsAsFaults = false
        
        do {
            let users = try context.fetch(request)
            if let appUser = users.first as? User {
                self.user = appUser
            }
        } catch {
            print("Fetching user failed.")
        }
    }
    
    func loginUser() {
        if self.user.pin == Int16(self.pin) {
            self.performSegue(withIdentifier: "loginShowAccount", sender: self)
        } else {
            self.showValidationError(alertMessage: "Incorrect PIN.")
        }
    }
    
    fileprivate func setUserLabel() {
        self.userLabel.text = "\(self.user.firstName!) \(self.user.lastName!)"
    }
    
    fileprivate func showValidationError(alertMessage: String) {
        let alert = UIAlertController(title: "Error", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func showPinDialog() {
        let pinPopover = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pinController") as! PinViewController
        pinPopover.parentController = self
        
        self.addChild(pinPopover)
        pinPopover.view.frame = self.view.frame
        self.view.addSubview(pinPopover.view)
    }
}
