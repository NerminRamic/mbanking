//
//  UserModel.swift
//  TestApp
//
//  Created by Nermin Ramic on 18/02/2019.
//  Copyright © 2019 Nermin Ramic. All rights reserved.
//

import Foundation
import UIKit

struct UserModel: Codable {
    let userId: String
    let accounts: [Account]
    
    private enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case accounts = "acounts"
    }
}
