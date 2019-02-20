//
//  AccountViewController.swift
//  TestApp
//
//  Created by Nermin Ramic on 15/02/2019.
//  Copyright © 2019 Nermin Ramic. All rights reserved.
//

import UIKit
import Foundation

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var ibanLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var userData: UserModel!
    var activeAccount: Account?
    var transactions: [Transaction] = [Transaction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.fetchUserData()
    }

    fileprivate func fetchUserData() {
        let urlString = "http://mobile.asseco-see.hr/builds/ISBD_public/Zadatak_1.json"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
                }
            
            self.parseUserDataJson(jsonData: dataResponse)
        }
        
        task.resume()
    }
    
    func parseUserDataJson(jsonData: Data) {
        let decoder = JSONDecoder()
        self.userData = try! decoder.decode(UserModel.self, from: jsonData)
        
        if let account = self.userData.accounts.first {
            self.activeAccount = account
            self.transactions = account.transactions
        }
        
        DispatchQueue.main.async {
            self.setActiveAccountInfo()
            self.tableView.reloadData()
        }
    }
    
    @IBAction func showChooseAccountDialog(_ sender: Any) {
        let chooseAccountPopover = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "chooseAccount") as! ChooseAccountViewController
        
        chooseAccountPopover.accounts = self.userData.accounts
        chooseAccountPopover.parentController = self
        
        self.addChild(chooseAccountPopover)
        chooseAccountPopover.view.frame = self.view.frame
        self.view.addSubview(chooseAccountPopover.view)
    }
    
    @IBAction func showOptions(_ sender: Any) {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let actionLogout = UIAlertAction(title: "Log Out", style: .destructive, handler: { action in
            self.logoutUser()
        })
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        sheet.addAction(actionLogout)
        sheet.addAction(actionCancel)
        self.present(sheet, animated: true, completion: nil)
    }
    
    
    func switchAccount(account: Account) {
        self.activeAccount = account
        self.setActiveAccountInfo()
        
        self.transactions.removeAll()
        self.transactions = account.transactions
        self.tableView.reloadData()
    }
    
    fileprivate func logoutUser() {
        performSegue(withIdentifier: "showLogin", sender: self)
    }
    
    fileprivate func setActiveAccountInfo() {
        if let activeAccount = self.activeAccount {
            DispatchQueue.main.async {
                self.currencyLabel.text = activeAccount.currency
                self.amountLabel.text = activeAccount.amount
                self.ibanLabel.text = activeAccount.iban
            }
        }
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let label = UILabel()
//
//        label.text = "January, 2018"
//        label.backgroundColor = UIColor(red: 0.29, green: 0.73, blue: 1.00, alpha: 1.0)
//        label.textColor = .white
//
//        return label
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! TransactionTableViewCell
        cell.setTransaction(transaction: self.transactions[indexPath.row])
        
        return cell
    }
}

extension Date {
    static func dateFromCustomString(customString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy."
        
        return dateFormatter.date(from: customString)!
    }
}


extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

