//
//  UserDefault.swift
//  neversitup
//
//  Created by Kasidid Wachirachai on 23/1/21.
//

import Foundation

class UserDefault {
    
    var username: String = ""
    var token: String = ""
    
    let userDefaultTokenKey = "userToken"
    
    static let shared = UserDefault()
    
    init() {
        guard let dict = UserDefaults.standard.object(forKey: userDefaultTokenKey) as? [String: String] else { return }
        username = dict["username"] ?? ""
        token = dict["token"] ?? ""
    }
    
    func saveUser(username: String?, token: String?) {
        if let username = username, let token = token {
            let userData = [
                "username": username,
                "token": token
            ]
            UserDefaults.standard.setValue(userData, forKey: userDefaultTokenKey)
            self.username = username
            self.token = token
        }
    }
    
    func isAnyUserLoggedIn() -> Bool {
        return UserDefaults.standard.object(forKey: userDefaultTokenKey) != nil
    }
    
    func clearUser() {
        UserDefaults.standard.setValue(nil, forKey: userDefaultTokenKey)
    }
    
}
