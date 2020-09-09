//
//  TeamsData.swift
//  HomeWork 11.2
//
//  Created by Vitalii on 09.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let teamsData = try? newJSONDecoder().decode(TeamsData.self, from: jsonData)

import Foundation

// MARK: - TeamsData
struct TeamsData: Codable {
    let api: teamsAPI
}

// MARK: - API
struct teamsAPI: Codable {
    let teams: [TeamProperties]?
}

// MARK: - TeamProperties
struct TeamProperties: Codable {
    let teamID: Int
    let name: String
    let logo: String
    let country: Country
    let founded: Int

    enum CodingKeys: String, CodingKey {
        case teamID = "team_id"
        case name, logo, country, founded
    }
}

enum Country: String, Codable {
    case england = "England"
    case wales = "Wales"
}

// MARK: - TeamParse

func parseTeams(withData data: Data) -> [Team]? {
    
    var teams = [Team]()
    
    do {
        let currentData = try JSONDecoder().decode(TeamsData.self, from: data)
        if let teamsData = currentData.api.teams {
        
            for teamElement in teamsData {
                guard let team = Team(teamData: teamElement) else { return nil }
                teams.append(team)
            }
        }
        
    } catch {
        print(error.localizedDescription)
    }
    
    return teams
}

