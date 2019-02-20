//
//  TransactionModel.swift
//  TestApp
//
//  Created by Nermin Ramic on 17/02/2019.
//  Copyright © 2019 Nermin Ramic. All rights reserved.
//

import Foundation
import UIKit

struct Transaction: Codable {
    let id: String
    let date: String
    let description: String
    let amount: String
    let type: String?
}
