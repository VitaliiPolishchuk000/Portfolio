//
//  NetworkManager.swift
//  HomeWork 11.2
//
//  Created by Vitalii on 09.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private let headers: HTTPHeaders = [
        "x-rapidapi-host": Constants.rapidApi.host,
        "x-rapidapi-key": Constants.rapidApi.key
]

    func fetchStatisticsTeam(withTeamID id: Int,
                             completionHandler: @escaping (_ statistics: Statistics) -> Void) {
        AF.request("https://api-football-v1.p.rapidapi.com/v2/statistics/2/\(id)", headers: headers).responseJSON { response in
            guard let data = response.data else { return }

            if let statistics = parseStatistics(withData: data) {
                completionHandler(statistics)
            }
        }
    }

    func fetchCurrentTeams(completionHandler: @escaping (_ teams: [Team]) -> Void) {
        AF.request("https://api-football-v1.p.rapidapi.com/v2/teams/league/2", headers: headers).responseJSON { response in
            guard let data = response.data else { return }
            
            if let teams = parseTeams(withData: data) {
                completionHandler(teams)
            }
        }
    }

    func fatchImage(withURL url: String, completionHandler: @escaping (_ image: UIImage) -> Void) {
        AF.request(url).responseJSON { response in
            guard let data = response.data else { return }
            guard let image = UIImage(data: data) else { return }
            completionHandler(image)
        }
    }
}
