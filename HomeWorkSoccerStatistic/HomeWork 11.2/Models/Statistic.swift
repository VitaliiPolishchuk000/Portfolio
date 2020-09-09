//
//  Statistic.swift
//  HomeWork 11.2
//
//  Created by Vitalii on 09.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import Foundation

struct Statistics {
    
    // Matches
    let matchsPlayed: Int
    let homeMatchs: Int
    let awayMatchs: Int
    
    let totalWins: Int
    let homeWins: Int
    let awayWins: Int
    
    let totalDraws: Int
    let homeDraws: Int
    let awayDraws: Int
    
    let totalLoses: Int
    let homeLoses: Int
    let awayLoses: Int
    
    //Goals
    let goalsScoredTotal: Int
    let goalsScoredHome: Int
    let goalsScoredAway: Int
    
    let goalsConcededTotal: Int
    let goalsConcededHome: Int
    let goalsConcededAway: Int
    
    
    init?(statisticsData: TeamStatistics) {
        
        matchsPlayed = statisticsData.matchs.matchsPlayed.total
        homeMatchs = statisticsData.matchs.matchsPlayed.home
        awayMatchs = statisticsData.matchs.matchsPlayed.away
        
        totalWins = statisticsData.matchs.wins.total
        homeWins = statisticsData.matchs.wins.home
        awayWins = statisticsData.matchs.wins.away
        
        totalDraws = statisticsData.matchs.draws.total
        homeDraws = statisticsData.matchs.draws.home
        awayDraws = statisticsData.matchs.draws.away
        
        totalLoses = statisticsData.matchs.loses.total
        homeLoses = statisticsData.matchs.loses.home
        awayLoses = statisticsData.matchs.loses.away
        
        goalsScoredTotal = statisticsData.goals.goalsFor.total
        goalsScoredHome = statisticsData.goals.goalsFor.home
        goalsScoredAway = statisticsData.goals.goalsFor.away
        
        goalsConcededTotal = statisticsData.goals.goalsAgainst.total
        goalsConcededHome = statisticsData.goals.goalsAgainst.home
        goalsConcededAway = statisticsData.goals.goalsAgainst.away
        
    }
}

