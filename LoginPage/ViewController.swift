//
//  ViewController.swift
//  LoginPage
//
//  Created by Bhupender Rawat on 23/06/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var logInButton: UIButton!
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var emailFieldStatus: UILabel!
    
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var passwordFieldStatus: UILabel!
    
    @IBAction private func ForgetPasswordButton(_ sender: Any) {
        print("Forget Password Button pressed.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailFieldStatus.text = ""
        passwordFieldStatus.text = ""
        isButtonEnabled(false)
        
        self.emailTextField.addTarget(self, action: #selector(emailTextFieldChanged), for: .editingChanged)
        
        self.passwordTextField.delegate = self
        self.passwordTextField.addTarget(self, action: #selector(passwordTextFieldChanged), for: .editingChanged)
        
    }
    
    @objc private func emailTextFieldChanged() {
        guard let email = emailTextField?.text else { return }
        
        if !email.validateEmail() {
            emailFieldStatus.text = "Invalid email"
        } else {
            emailFieldStatus.text = ""
        }
        
        enableLoginButton()
    }
    
    @objc private func passwordTextFieldChanged() {
        guard let password = passwordTextField?.text else { return }
        
        if password.count < 8 {
            passwordFieldStatus.text = "Should be of length at least 8"
        } else if !password.containsUpperCase() {
            passwordFieldStatus.text = "Should contain at least an uppercase character"
        } else if !password.containsLowerCase() {
            passwordFieldStatus.text = "Should contain at least a lowercase character"
        } else if !password.containsDigit() {
            passwordFieldStatus.text = "Should contain at least a digit"
        } else if !password.containsSpecialCharacters() {
            passwordFieldStatus.text = "Should contain at least a special character $@!%*?&#"
        } else if !password.validatePassword() {
            passwordFieldStatus.text = "Remove special characters other than $@!%*?&#"
        } else {
            passwordFieldStatus.text = ""
        }
        
        enableLoginButton()
        
    }
    
    @objc private func enableLoginButton() {
        guard let email = emailTextField?.text else { return }
        guard let password = passwordTextField?.text else { return }


        if email.validateEmail() && password.validatePassword() {
            isButtonEnabled(true)
        } else {
           isButtonEnabled(false)
        }
        
    }
    
    private func isButtonEnabled(_ value: Bool) {
        logInButton.isEnabled = value
        logInButton.backgroundColor = value ? UIColor.blue: UIColor.gray
    }
    
}


//MARK:- UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 15
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
       
        return newString.length <= maxLength
    }
    
}

