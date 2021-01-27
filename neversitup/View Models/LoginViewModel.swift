//
//  loginViewModel.swift
//  neversitup
//
//  Created by Kasidid Wachirachai on 23/1/21.
//

import Foundation

class LoginViewModel {
    
    lazy var api = ApiService()
    
    func login(username: String, password: String, _ complete: @escaping ((_ complete: Bool, _ errorText: String) -> ())) {
        api.postLogin(username: username, password: password) { (finished, response) in
            if finished {
                complete(true, "")
            } else {
                let errorText = response["description"] as? String ?? ""
                complete(false, errorText)
            }
        }
    }
}
