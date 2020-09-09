//
//  TeamsTableViewCell.swift
//  HomeWork 11.2
//
//  Created by Vitalii on 09.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import UIKit

class TeamsTableViewCell: UITableViewCell {

    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    
    static let identifier = "TeamsTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "TeamsTableViewCell", bundle: nil)
    }
    
    func configure(withTeam team: Team) {
        teamNameLabel.text = team.teamName
        NetworkManager().fatchImage(withURL: team.teamLogo) { image in
            self.teamImageView.image = image
        }
    }
    
}
