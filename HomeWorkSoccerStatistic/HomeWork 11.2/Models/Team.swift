//
//  Team.swift
//  HomeWork 11.2
//
//  Created by Vitalii on 09.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import Foundation

struct Team {
    
    let teamID: Int
    let teamName: String
    let teamLogo: String
    let teamCountry: String
    let teamFounded: Int
    
    init?(teamData: TeamProperties) {
        teamID = teamData.teamID
        teamName = teamData.name
        teamCountry = teamData.country.rawValue
        teamLogo = teamData.logo
        teamFounded = teamData.founded
    }
}
