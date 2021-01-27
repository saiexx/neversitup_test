//
//  LoginViewController.swift
//  neversitup
//
//  Created by Kasidid Wachirachai on 22/1/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    var viewModel: LoginViewModel?
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var isPasswordShow: Bool = false {
        didSet {
            passwordTextField.isSecureTextEntry = !isPasswordShow
            showPasswordButton.tintColor = (isPasswordShow) ? .systemBlue : .systemGray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = LoginViewModel()
        checkLoginStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        clearTextField()
    }
    
    private func checkLoginStatus() {
        let userDefault = UserDefault.shared
        if userDefault.isAnyUserLoggedIn() {
            presentDashbaordViewController()
        }
    }
    
    private func clearTextField() {
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    private func presentDashbaordViewController() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "Dashboard") as DashboardViewController
            vc.viewModel = DashboardViewModel()
            
            let navigationVC = UINavigationController(rootViewController: vc)
            
            self.view.window?.rootViewController = navigationVC
            self.view.window?.makeKeyAndVisible()
        }
    }
    
    private func showLoginErrorLabel(text: String) {
        self.errorLabel.text = "Error: \(text)"
        self.errorLabel.isHidden = false
    }
    
    @IBAction private func showPasswordButtonDidPress(_ sender: UIButton) {
        isPasswordShow = !isPasswordShow
    }
    
    @IBAction func loginButtonDidPress(_ sender: UIButton) {
        errorLabel.isHidden = true
        guard let username = usernameTextField.text, let password = passwordTextField.text else { return }
        viewModel?.login(username: username, password: password) { [weak self] (complete, errorText) in
            guard let self = self else { return }
            if complete {
                self.presentDashbaordViewController()
            } else {
                self.showLoginErrorLabel(text: errorText)
            }
        }
    }
    
    @IBAction func textFieldValueDidChange(_ sender: UITextField) {
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            loginButton.isEnabled = false
            //Disable login button when username and password textfields are empty
        } else {
            loginButton.isEnabled = true
            //Enable login button when username and password textfields are not empty
        }
    }
    
}
