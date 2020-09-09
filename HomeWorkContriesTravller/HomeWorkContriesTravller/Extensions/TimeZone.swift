//
//  TimeZone.swift
//  HomeWorkContriesTravller
//
//  Created by Vitalii on 18.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import Foundation

extension TimeZone {

    func offsetFromUTC() -> String {
        let localTimeZoneFormatter = DateFormatter()
        localTimeZoneFormatter.timeZone = TimeZone(identifier: "\(TimeZone.knownTimeZoneIdentifiers[0])")
        localTimeZoneFormatter.dateFormat = "Z"
        return localTimeZoneFormatter.string(from: Date())
        
    }

    func offsetInHours() -> String {

        let hours = secondsFromGMT()/3600
        let minutes = abs(secondsFromGMT()/60) % 60
        let tz_hr = String(format: "%+.2d:%.2d", hours, minutes) // "+hh:mm"
        return tz_hr
        
    }
    
}
