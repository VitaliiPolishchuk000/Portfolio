//
//  StatisticData.swift
//  HomeWork 11.2
//
//  Created by Vitalii on 09.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let statisticData = try? newJSONDecoder().decode(StatisticData.self, from: jsonData)

import Foundation

// MARK: - StatisticData
struct StatisticData: Codable {
    let api: statisticAPI
}

// MARK: - API
struct statisticAPI: Codable {
    let statistics: TeamStatistics?
}

// MARK: - Statistics
struct TeamStatistics: Codable {
    let matchs: Matchs
    let goals: Goals
}

// MARK: - Matchs
struct Matchs: Codable {
    let matchsPlayed, wins, draws, loses: GoalsAgainst
}

// MARK: - Goals
struct Goals: Codable {
    let goalsFor, goalsAgainst: GoalsAgainst
}

// MARK: - GoalsAgainst
struct GoalsAgainst: Codable {
    let home, away, total: Int
}

func parseStatistics(withData data: Data) -> Statistics? {
    
    var statistics: Statistics!
    
    do {
        let currentData = try JSONDecoder().decode(StatisticData.self, from: data)
        if let statisticsData = currentData.api.statistics {
            if let stat = Statistics(statisticsData: statisticsData) {
                statistics = stat
                }
        }
        
    } catch {
        print(error.localizedDescription)
    }
    
    return statistics
}


