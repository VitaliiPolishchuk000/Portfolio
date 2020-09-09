//
//  TeamStatisticVC.swift
//  HomeWork 11.2
//
//  Created by Vitalii on 11.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import Foundation
import UIKit

class TeamStatisticVC: UIViewController {
    
    var idTeam: Int!
    
    @IBOutlet weak var matchTotalLabel: UILabel!
    @IBOutlet weak var matchHomeLabel: UILabel!
    @IBOutlet weak var matchAwayLabel: UILabel!
    
    @IBOutlet weak var winsTotalLabel: UILabel!
    @IBOutlet weak var winsHomeLabel: UILabel!
    @IBOutlet weak var winsAwayLabel: UILabel!
    
    @IBOutlet weak var losesTotalLabel: UILabel!
    @IBOutlet weak var losesHomeLabel: UILabel!
    @IBOutlet weak var losesAwayLabel: UILabel!
    
    @IBOutlet weak var drawsTotalLabel: UILabel!
    @IBOutlet weak var drawsHomeLabel: UILabel!
    @IBOutlet weak var drawsAwayLabel: UILabel!
    
    @IBOutlet weak var scoredTotalLabel: UILabel!
    @IBOutlet weak var scoredHomeLabel: UILabel!
    @IBOutlet weak var scoredAwayLabel: UILabel!
    
    @IBOutlet weak var concedTotalLabel: UILabel!
    @IBOutlet weak var consedHomeLabel: UILabel!
    @IBOutlet weak var consedAwayLabel: UILabel!
    
    
    override func viewDidLoad() {
          super.viewDidLoad()
    
        NetworkManager().fetchStatisticsTeam(withTeamID: idTeam) { statistics in
            DispatchQueue.main.async {
            
                self.matchTotalLabel.text = String(statistics.matchsPlayed)
                self.matchHomeLabel.text = String(statistics.homeMatchs)
                self.matchAwayLabel.text = String(statistics.awayMatchs)

                self.winsTotalLabel.text = String(statistics.totalWins)
                self.winsHomeLabel.text = String(statistics.homeWins)
                self.winsAwayLabel.text = String(statistics.awayWins)
                
                self.losesTotalLabel.text = String(statistics.totalLoses)
                self.losesHomeLabel.text = String(statistics.homeLoses)
                self.losesAwayLabel.text = String(statistics.awayLoses)
                
                self.drawsTotalLabel.text = String(statistics.totalDraws)
                self.drawsHomeLabel.text = String(statistics.homeDraws)
                self.drawsAwayLabel.text = String(statistics.awayDraws)
                
                self.scoredTotalLabel.text = String(statistics.goalsScoredTotal)
                self.scoredHomeLabel.text = String(statistics.goalsScoredHome)
                self.scoredAwayLabel.text = String(statistics.goalsScoredAway)
                
                self.concedTotalLabel.text = String(statistics.goalsConcededTotal)
                self.consedHomeLabel.text = String(statistics.goalsConcededHome)
                self.consedAwayLabel.text = String(statistics.goalsConcededAway)
                
            }
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
