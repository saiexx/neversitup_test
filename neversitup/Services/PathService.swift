//
//  PathService.swift
//  neversitup
//
//  Created by Kasidid Wachirachai on 23/1/21.
//

import Foundation

let baseURL: String = "https://us-central1-iostesting-b3165.cloudfunctions.net/mobileApi/api/v1"

struct PathService {
    
    static let login: URL? = URL(string: "\(baseURL)/login")
    static let getCustomerDetail: URL? = URL(string: "\(baseURL)/getCustomerDetail")
    
}
