//
//  ViewController.swift
//  LoginPage
//
//  Created by Bhupender Rawat on 23/06/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func ForgetPasswordButton(_ sender: Any) {
        print("Forget Password Button pressed.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInButton.isEnabled = false
        logInButton.backgroundColor = UIColor.gray
        
        self.emailTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        
        self.passwordTextField.delegate = self
        self.passwordTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    @objc private func textFieldEditingChanged() {
        guard let email = emailTextField?.text else { return }
        guard let password = passwordTextField?.text else { return }
        
        if email.validateEmail() && password.validatePassword() {
            logInButton.isEnabled = true
            logInButton.backgroundColor = UIColor.blue
        } else {
            logInButton.isEnabled = false
            logInButton.backgroundColor = UIColor.gray
        }
    }
}

extension String {
    
    func validateEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return applyPredicateOnRegex(regexStr: emailRegEx)
    }
    
    func validatePassword() -> Bool {
        let passRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{8,}"

        return applyPredicateOnRegex(regexStr: passRegEx)
    }
    
    func applyPredicateOnRegex(regexStr: String) -> Bool {
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateString = NSPredicate(format: "SELF MATCHES %@", regexStr)
        let isValidString = validateString.evaluate(with: trimmedString)
        return isValidString
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

