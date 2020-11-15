//
//  NetworkHelpers.swift
//  CovidStatisticX
//
//  Created by Vitalii on 29.09.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case GET, POST, PUT, PATCH, DELETE
}

final class NetworkHelpers {
    
    // MARK: - Properties
    
    static let shared = NetworkHelpers()
    private init() {}
    
    // MARK: - Methods
    
    func parseCovidStatistic(_ data: Data) -> CovidStatistic? {
        do {
            let statistic = try JSONDecoder().decode(CovidStatistic.self, from: data)
            return statistic
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func fetchCovidStatistic(completion: @escaping (CovidStatistic?) -> Void) {
            
        let headers: HTTPHeaders = ["x-rapidapi-host": "covid-19-tracking.p.rapidapi.com",                                                 "x-rapidapi-key" : "5149ae2853msh263c0299a79f836p1b75acjsn9841e9ac2704"]

        NetworkManager.shared.requestApi(stringURL: "https://covid-19-tracking.p.rapidapi.com/v1", method: .GET, headers: headers) { (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                let covidStatistic = self.parseCovidStatistic(data)
                completion(covidStatistic)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
}
