//
//  Currencies.swift
//  HomeWorkContriesTravller
//
//  Created by Vitalii on 07.07.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import Foundation


// MARK: - Currency
struct Currency: Codable {
    let currencies: [String: String]
    let status: String
}

