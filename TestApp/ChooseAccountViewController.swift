//
//  ChooseAccountViewController.swift
//  TestApp
//
//  Created by Nermin Ramic on 18/02/2019.
//  Copyright © 2019 Nermin Ramic. All rights reserved.
//

import UIKit

class ChooseAccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var parentController: AccountViewController!
    var accounts: [Account] = [Account]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let accountCell = tableView.dequeueReusableCell(withIdentifier: "accountCell", for: indexPath) as! AccountTableViewCell
        let accountToSet = self.accounts[indexPath.row]
        
        if self.parentController.activeAccount?.id == accountToSet.id {
            accountCell.isUserInteractionEnabled = false
            accountCell.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        }
        accountCell.setAccount(account: accountToSet)
        
        return accountCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.parentController.switchAccount(account: self.accounts[indexPath.row])
        self.view.removeFromSuperview()
    }
}
