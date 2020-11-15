//
//  NetworkError.swift
//  CovidStatisticX
//
//  Created by Vitalii on 29.09.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import Foundation

enum NetworkError {
    case noNetwork
    case failed
    case cancelled
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noNetwork:
            return NSLocalizedString("No network", comment: "")
        case .failed:
            return NSLocalizedString("Failed to get a response", comment: "")
        case .cancelled:
            return NSLocalizedString("Server request canceled", comment: "")
        }
    }
}

