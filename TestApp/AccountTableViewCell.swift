//
//  AccountTableViewCell.swift
//  TestApp
//
//  Created by Nermin Ramic on 19/02/2019.
//  Copyright © 2019 Nermin Ramic. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    @IBOutlet weak var accountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setAccount(account: Account) {
        self.accountLabel.text = account.currency
    }
}
