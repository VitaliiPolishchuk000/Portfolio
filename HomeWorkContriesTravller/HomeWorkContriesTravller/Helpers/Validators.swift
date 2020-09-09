//
//  MainViewController.swift
//  HomeWorkContriesTravller
//
//  Created by Vitalii on 17.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import Foundation

class Validators {
    
    static func isFilled(_ email: String?, _ password: String?, _ confirmPassword: String?) -> Bool {
        guard let email = email,
            let password = password,
            let confirmPassword = confirmPassword,
            password != "",
            confirmPassword != "",
            email != "" else { return false }
        return true
    }
    
    static func isFilled(address: String?, phone: String?) -> Bool {
        guard let address = address,
            let phone = phone,
            address != "",
            phone != "" else { return false }
        return true
    }
    
    static func isFilled(gender: String?, bornDate: String?, timeZone: String?) -> Bool {
        guard let gender = gender,
            let bornDate = bornDate,
            let timeZone = timeZone,
            gender != "",
            bornDate != "",
            timeZone != "" else { return false }
        return true
    }
    
   static func isValidInputEmail (_ userEmail: String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: userEmail)
    }

    static func isValidPassConfirm(userPassword: String?, userPasswordConfirm: String?) -> Bool {
        guard userPassword == userPasswordConfirm else { return false }
        guard let pass = userPassword else { return false }
        return pass.count > 5
    }
    
    static func isValidNameField(name: String) -> Bool {
        if !name.isEmptyOrWhitespace() && name.count >= 3 {
            return true
        } else {
            return false
        }
    }
    
    static func isFilledCurrency(currency1: String, currency2: String) -> Bool {
        if (!currency1.isEmptyOrWhitespace() && currency1.count < 4) && (!currency2.isEmptyOrWhitespace() && currency2.count < 4) {
            return true
        } else {
            return false
        }
    }
    
}
