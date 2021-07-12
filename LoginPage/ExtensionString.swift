//
//  ExtensionString.swift
//  LoginPage
//
//  Created by Bhupender Rawat on 12/07/21.
//

import Foundation

extension String {
    
    func validateEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return applyPredicateOnRegex(regexStr: emailRegEx)
    }
    
    func validatePassword() -> Bool {
        let passRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{8,}"
        return applyPredicateOnRegex(regexStr: passRegEx)
    }
    
    func containsUpperCase() -> Bool {
        let upperCaseRegEx = ".*[A-Z]+.*"
        return applyPredicateOnRegex(regexStr: upperCaseRegEx)
    }
    
    func containsLowerCase() -> Bool {
        let lowerCaseRegEx = ".*[a-z]+.*"
        return applyPredicateOnRegex(regexStr: lowerCaseRegEx)
    }
    
    func containsDigit() -> Bool {
        let digitRegEx = ".*[0-9]+.*"
        return applyPredicateOnRegex(regexStr: digitRegEx)
    }
    
    func containsSpecialCharacters() -> Bool {
        let specialCharacterRegex = ".*[$@$!%*?&#]+.*"
        return applyPredicateOnRegex(regexStr: specialCharacterRegex)
    }
    
    func applyPredicateOnRegex(regexStr: String) -> Bool {
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateString = NSPredicate(format: "SELF MATCHES %@", regexStr)
        let isValidString = validateString.evaluate(with: trimmedString)
        return isValidString
    }
}
