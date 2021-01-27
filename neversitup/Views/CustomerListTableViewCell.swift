//
//  CustomerListTableViewCell.swift
//  neversitup
//
//  Created by Kasidid Wachirachai on 25/1/21.
//

import UIKit

class CustomerListTableViewCell: UITableViewCell {
    
    static let identifier: String = "CustomerList"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var customerImageView: UIImageView!
    
    var customer: Customer? {
        didSet {
            guard let customer = customer else { return }
            nameLabel.text = customer.name
            idLabel.text = customer.id
            customerImageView.image = customer.image
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        UIView.animate(withDuration: 0.1) {
            self.backgroundColor = highlighted ? .lightGray : .clear
        }
    }
    
}
