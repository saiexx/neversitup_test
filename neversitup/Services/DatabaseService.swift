//
//  DatabaseService.swift
//  neversitup
//
//  Created by Kasidid Wachirachai on 23/1/21.
//

import Foundation
import RealmSwift

class DatabaseService {
    
    let realm = try? Realm()
    
    func addCustomers(customers: [Customer], _ complete: @escaping ((_ complete: Bool) -> ())) {
        guard let realm = realm else {
            print("Realm is nil.")
            complete(false)
            return
        }
        do {
            try realm.write {
                customers.forEach {
                    realm.add($0, update: .all)
                }
                complete(true)
            }
        } catch {
            print(error)
            complete(false)
        }
//        print(realm.configuration.fileURL)
    }
    
    func clearAllCustomers() {
        guard let realm = realm else {
            print("Realm is nil.")
            return
        }
        do {
            try realm.write {
                let results = realm.objects(Customer.self)
                realm.delete(results)
            }
        } catch {
            print(error)
        }
    }
    
    func getCustomers() -> [Customer] {
        guard let realm = realm else {
            print("Realm is nil.")
            return []
        }
        let results = realm.objects(Customer.self)
        return Array(results)
    }
}
