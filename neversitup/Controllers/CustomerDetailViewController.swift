//
//  CustomerDetailViewController.swift
//  neversitup
//
//  Created by Kasidid Wachirachai on 24/1/21.
//

import UIKit

class CustomerDetailViewController: UIViewController {
    
    var viewModel: CustomerDetailViewModel?
    
    @IBOutlet weak var customerDetailTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    private func setUI() {
        let headNib = UINib(nibName: "CustomerDetailHeadTableViewCell", bundle: nil)
        let detailNib = UINib(nibName: "CustomerDetailStatusTableViewCell", bundle: nil)
        
        customerDetailTableView.register(headNib, forCellReuseIdentifier: CustomerDetailHeadTableViewCell.identifier)
        customerDetailTableView.register(detailNib, forCellReuseIdentifier: CustomerDetailStatusTableViewCell.identifier)
        
        customerDetailTableView.dataSource = self
    }
    

    @IBAction private func backButtonDidPress(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

}

extension CustomerDetailViewController: UITableViewDataSource {
    
    enum CustomerDetailTableViewRow: Int {
        case head = 0
        case status = 1
        
        init?(indexPath: IndexPath) {
            self.init(rawValue: indexPath.row)
        }
        
        static var count: Int {
            return CustomerDetailTableViewRow.status.rawValue + 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CustomerDetailTableViewRow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch CustomerDetailTableViewRow(indexPath: indexPath) {
        case .head:
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomerDetailHeadTableViewCell.identifier, for: indexPath) as! CustomerDetailHeadTableViewCell
            cell.customer = viewModel?.customer
            return cell
        case .status:
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomerDetailStatusTableViewCell.identifier, for: indexPath) as! CustomerDetailStatusTableViewCell
            cell.customer = viewModel?.customer
            return cell
        case .none:
            return UITableViewCell()
        }
    }
    
}
