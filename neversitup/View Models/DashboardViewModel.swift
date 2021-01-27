//
//  DashboardViewModel.swift
//  neversitup
//
//  Created by Kasidid Wachirachai on 25/1/21.
//

import Foundation

class DashboardViewModel {
    
    lazy var db = DatabaseService()
    lazy var userDefault = UserDefault.shared
    lazy var api = ApiService()
    
    var customers: [Customer] = []
    
    ///Fetch customers from realm
    func fetchCustomers(_ complete: @escaping (()->())) {
        customers = db.getCustomers()
        complete()
    }
    
    ///Get customer detail
    func getCustomerDetail(indexPath: IndexPath, _ complete: @escaping ((_ customer: Customer)->())) {
        let customer = getCustomer(by: indexPath)
        api.postCustomerDetail(customer: customer) { (finished, response) in
            if finished {
                let newCustomer = response["customer"] as! Customer
                complete(newCustomer)
            }
        }
    }
    
    ///Logout and clear all data about this user
    func logout(_ complete: @escaping (() -> ())) {
        db.clearAllCustomers()
        userDefault.clearUser()
        complete()
    }
    
    ///Current user username
    var username: String {
        return userDefault.username
    }
    
    ///Get customer for display in tableview
    func getCustomer(by indexPath: IndexPath) -> Customer {
        return customers[indexPath.row]
    }
    
    var numberOfCustomers: Int {
        return customers.count
    }
    
}
