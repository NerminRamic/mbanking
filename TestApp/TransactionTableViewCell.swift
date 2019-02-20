//
//  TableViewCell_Transaction.swift
//  TestApp
//
//  Created by Nermin Ramic on 17/02/2019.
//  Copyright © 2019 Nermin Ramic. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setTransaction(transaction: Transaction) {
        self.amountLabel.text = transaction.amount
        self.descriptionLabel.text = transaction.description
        self.typeLabel.text = transaction.type
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy."
        if let transactionDate = formatter.date(from: transaction.date) {
            let calendar = Calendar(identifier: .gregorian)
            self.dayLabel.text = String(calendar.component(.day, from: transactionDate))
            
            formatter.dateFormat = "MMMM"
            self.monthLabel.text = formatter.string(from: transactionDate)
        }
    }
}
