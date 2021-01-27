//
//  CustomerDetailStatusTableViewCell.swift
//  neversitup
//
//  Created by Kasidid Wachirachai on 27/1/21.
//

import UIKit

class CustomerDetailStatusTableViewCell: UITableViewCell {
    
    static let identifier: String = "CustomerDetailStatus"
    
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var premiumImageView: UIImageView!
    
    var customer: Customer? {
        didSet {
            guard let customer = customer else { return }
            genderLabel.text = Gender.init(rawValue: customer.sex ?? "Male")?.emoji
            gradeLabel.text = customer.customerGrade
            premiumImageView.image = UIImage(systemName: (customer.isCustomerPremium.value ?? false) ? "star.fill" : "star")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    enum Gender: String {
        case Male
        case Female
        
        var emoji: String {
            switch self {
            case .Male: return "🙋‍♂️"
            case .Female: return "🙋‍♀️"
            }
        }
    }

}
