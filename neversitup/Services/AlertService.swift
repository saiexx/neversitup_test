//
//  AlertService.swift
//  neversitup
//
//  Created by Kasidid Wachirachai on 27/1/21.
//

import Foundation
import UIKit

class AlertService {
    
    func logoutAlert(_ viewController: UIViewController, _ handler: @escaping ((UIAlertAction) -> Void)) {
        let username: String = UserDefault.shared.username
        let alert = UIAlertController(title: "Log out", message: "Do you want to log out from\n\(username)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler: handler))
        viewController.present(alert, animated: true)
    }
}
