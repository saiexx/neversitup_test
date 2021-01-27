//
//  ApiService.swift
//  neversitup
//
//  Created by Kasidid Wachirachai on 23/1/21.
//

import Foundation

typealias DictionaryAny = [String: Any]
typealias ApiComplete = (_ complete: Bool, _ response: DictionaryAny) -> Void

struct ApiService {
    
    let session = URLSession.shared
    
    private func postRequest(url: URL?, parameterBody: DictionaryAny, _ complete: @escaping ApiComplete) {
        
        guard let url = url else {
            complete(false, [ "description": "There's no URL." ])
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterBody, options: []) else {
            complete(false, [ "description": "Body is missing." ])
            return
        }
        
        request.httpBody = httpBody
        
        session.dataTask(with: request) { (data, _, error) in
            if let data = data {
                complete(true, [ "result": data ])
            } else {
                complete(false, [ "description": "There's no data." ])
            }
            if let error = error {
                complete(false, [ "description": error.localizedDescription ])
            }
        }.resume()
        
    }
    
    /// Post  request login
    /// - Parameters:
    ///   - username: user's username
    ///   - password: user's password
    ///   - complete: completion at escape
    public func postLogin(username: String, password: String, _ complete: @escaping ApiComplete) {
        let parameter: DictionaryAny = [
            "username" : username,
            "password" : password
        ]
        postRequest(url: PathService.login, parameterBody: parameter) { (finished, response) in
            if finished {
                guard let data = response["result"] as? Data else { return }
                do {
                    
                    let user = try JSONDecoder().decode(User.self, from: data)
                    
                    let userDefault = UserDefault.shared
                    
                    let token = user.token
                    let username = username
                    
                    userDefault.saveUser(username: username, token: token)
                    
                    DatabaseService().addCustomers(customers: user.customers) { finished in
                        if finished {
                            complete(true, [:])
                        } else {
                            complete(false, [ "description": "Database error"])
                        }
                    }
                } catch {
                    print(error)
                    complete(false, [ "description": error.localizedDescription ])
                }
            }
        }
    }
    
    public func postCustomerDetail(customer: Customer, _ complete: @escaping ApiComplete) {
        let userDefault = UserDefault.shared
        let parameter: DictionaryAny = [
            "token": userDefault.token,
            "customerId": customer.id
        ]
        
        postRequest(url: PathService.getCustomerDetail, parameterBody: parameter) { (finished, response) in
            if finished {
                guard let data = response["result"] as? Data else { return }
                do {
                    let detailResponse = try JSONDecoder().decode(CustomerResponse.self, from: data)
                    complete(true, ["customer": detailResponse.customer])
                } catch {
                    print(error)
                    complete(false, [ "description": error.localizedDescription ])
                }
            }
        }
    }
}
