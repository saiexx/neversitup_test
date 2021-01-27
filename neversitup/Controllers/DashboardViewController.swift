//
//  DashboardViewController.swift
//  neversitup
//
//  Created by Kasidid Wachirachai on 24/1/21.
//

import UIKit

class DashboardViewController: UIViewController {

    var viewModel: DashboardViewModel?
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var customerListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    private func setUI() {
        
        welcomeLabel.text = "Hi, \(viewModel?.username ?? "")"
        
        let customerListCellNib = UINib(nibName: "CustomerListTableViewCell", bundle: nil)
        customerListTableView.register(customerListCellNib, forCellReuseIdentifier: CustomerListTableViewCell.identifier)
        customerListTableView.dataSource = self
        customerListTableView.delegate = self
        
        viewModel?.fetchCustomers { [weak self] in
            guard let self = self else { return }
            self.customerListTableView.reloadData()
        }
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func presentCustomerDetail(indexPath: IndexPath) {
        viewModel?.getCustomerDetail(indexPath: indexPath, { [weak self] customer in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "Detail") as CustomerDetailViewController
                vc.viewModel = CustomerDetailViewModel(customer: customer)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        })
    }
    
    @IBAction private func logoutButtonDidPress(_ sender: UIButton) {
        AlertService().logoutAlert(self) { [weak self] _ in
            guard let self = self else { return }
            self.viewModel?.logout {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "Login") as LoginViewController
                
                self.view.window?.rootViewController = vc
                self.view.window?.makeKeyAndVisible()
            }
        }
    }

}

extension DashboardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfCustomers ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerList", for: indexPath) as! CustomerListTableViewCell
        cell.customer = viewModel?.getCustomer(by: indexPath)
        return cell
    }
}

extension DashboardViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentCustomerDetail(indexPath: indexPath)
    }
}
