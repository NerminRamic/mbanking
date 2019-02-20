//
//  AccountModel.swift
//  TestApp
//
//  Created by Nermin Ramic on 17/02/2019.
//  Copyright © 2019 Nermin Ramic. All rights reserved.
//

import Foundation
import UIKit

struct Account: Codable {
    let id: String
    let iban: String
    let amount: String
    let currency: String
    let transactions: [Transaction]
    
    private enum CodingKeys: String, CodingKey {
        case id, amount, currency, transactions
        case iban = "IBAN"
    }
}
