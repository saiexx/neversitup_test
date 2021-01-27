//
//  User.swift
//  neversitup
//
//  Created by Kasidid Wachirachai on 24/1/21.
//

import Foundation

class User: Codable {
    var token: String
    var customers: [Customer] = []
}
