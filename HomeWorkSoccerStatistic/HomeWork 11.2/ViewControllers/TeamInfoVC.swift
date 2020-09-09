//
//  TeamInfoVC.swift
//  HomeWork 11.2
//
//  Created by Vitalii on 11.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import Foundation
import UIKit

class TeamInfoVC: UIViewController {
    
    @IBOutlet weak var teamInfoImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamCountryLabel: UILabel!
    @IBOutlet weak var teamFoundedLabel: UILabel!
    
    var team: Team!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamNameLabel.text = team.teamName
        teamCountryLabel.text = team.teamCountry
        teamFoundedLabel.text = String(team.teamFounded)
        
        NetworkManager().fatchImage(withURL: team.teamLogo) { image in
            self.teamInfoImageView.image = image
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
