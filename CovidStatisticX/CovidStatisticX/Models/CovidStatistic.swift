//
//  CovidStatistic.swift
//  CovidStatisticX
//
//  Created by Vitalii on 29.09.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import Foundation

// MARK: - CovidStatistic
typealias CovidStatistic = [CovidStatisticElement]

// MARK: - CovidStatisticElement
struct CovidStatisticElement: Codable {
    let activeCasesText, countryText, lastUpdate, newCasesText, newDeathsText, totalCasesText, totalDeathsText, totalRecoveredText: String?
    var totalCasesDouble: Double {
        return stringToDoubleFiltered(string: totalCasesText)
        }
    var activeCasesDouble: Double {
        return stringToDoubleFiltered(string: activeCasesText)
        }
    var totalRecoveredDouble: Double {
        return stringToDoubleFiltered(string: totalRecoveredText)
        }
    var totalDeathsDouble: Double {
        return stringToDoubleFiltered(string: totalDeathsText)
        }
    
    enum CodingKeys: String, CodingKey {
        
        case activeCasesText = "Active Cases_text"
        case countryText = "Country_text"
        case lastUpdate = "Last Update"
        case newCasesText = "New Cases_text"
        case newDeathsText = "New Deaths_text"
        case totalCasesText = "Total Cases_text"
        case totalDeathsText = "Total Deaths_text"
        case totalRecoveredText = "Total Recovered_text"
    }
    
    private func stringToDoubleFiltered(string: String?) -> Double {
        var filtredDoubleValue = 0.0
        var filtered = ""
        if let _ = string {
            filtered = string!.filter("0123456789.".contains)
            filtredDoubleValue = Double(filtered) ?? 0.0
        }
        return filtredDoubleValue
    }
}


