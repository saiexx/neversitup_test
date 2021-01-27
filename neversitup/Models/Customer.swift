//
//  Customer.swift
//  neversitup
//
//  Created by Kasidid Wachirachai on 23/1/21.
//

import Foundation
import RealmSwift

class Customer: Object, Codable {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var sex: String?
    @objc dynamic var customerGrade: String?
    let isCustomerPremium = RealmOptional<Bool>()
    
    @objc dynamic var customerImageName: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case id, name, sex, customerGrade, isCustomerPremium, customerImageName
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        sex = try container.decodeIfPresent(String.self, forKey: .sex)
        customerGrade = try container.decodeIfPresent(String.self, forKey: .customerGrade)
        isCustomerPremium.value = try container.decodeIfPresent(Bool.self, forKey: .isCustomerPremium)
        customerImageName = "image\((1...6).randomElement() ?? 0)"
    }
    
    var image: UIImage? {
        return UIImage(named: customerImageName)
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    override class func ignoredProperties() -> [String] {
        return ["sex", "customerGrade", "isCustomerPremium", "image"]
    }
}

class CustomerResponse: Codable {
    var status: Int
    var customer: Customer
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case customer = "data"
    }
}
