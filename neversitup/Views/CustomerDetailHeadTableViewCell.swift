//
//  CustomerDetailHeadTableViewCell.swift
//  neversitup
//
//  Created by Kasidid Wachirachai on 27/1/21.
//

import UIKit

class CustomerDetailHeadTableViewCell: UITableViewCell {
    
    static let identifier: String = "CustomerDetailHead"
    
    @IBOutlet weak var customerImageView: UIImageView!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var customerIdLabel: UILabel!
    
    var customer: Customer? {
        didSet {
            guard let customer = customer else { return }
            customerImageView.image = customer.image
            customerNameLabel.text = customer.name
            customerIdLabel.text = customer.id
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

}
