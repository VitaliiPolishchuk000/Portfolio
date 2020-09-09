//
//  MainViewController.swift
//  HomeWorkContriesTravller
//
//  Created by Vitalii on 17.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import Foundation

enum FirestoreError {
    case notFilled
    case photoNotExist
}

extension FirestoreError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString(kFillInAllTheInputFields, comment: "")
        case .photoNotExist:
            return NSLocalizedString(kPhotoNotExist, comment: "")
        }
    }
}
