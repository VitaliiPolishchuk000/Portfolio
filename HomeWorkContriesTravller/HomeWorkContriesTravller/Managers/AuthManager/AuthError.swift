//
//  MainViewController.swift
//  HomeWorkContriesTravller
//
//  Created by Vitalii on 17.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import Foundation

enum AuthError {
    case notFilled
    case invalidEmail
    case passwordsNotMatched
    case serverError
    case unknownError
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Fill in all the input fields", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Email format is not valid", comment: "")
        case .passwordsNotMatched:
            return NSLocalizedString("Password mismatch", comment: "")
        case .serverError:
            return NSLocalizedString("Server error", comment: "")
        case .unknownError:
            return NSLocalizedString("Unknown error", comment: "")
        }
    }
}
