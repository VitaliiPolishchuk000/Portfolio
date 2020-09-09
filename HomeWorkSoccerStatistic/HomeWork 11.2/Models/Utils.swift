//
//  Utils.swift
//  HomeWork 11.2
//
//  Created by Vitalii on 06.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import Foundation
import UIKit

func isValidInputEmail (userEmail: String?) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPredicate.evaluate(with: userEmail)
}

func isValidPassConfirm(userPassword: String?, userPasswordConfirm: String?) -> Bool {
    guard userPassword == userPasswordConfirm else { return false }
    guard let pass = userPassword else { return false }
    return pass.count > 5
}

