//
//  MainViewController.swift
//  HomeWorkContriesTravller
//
//  Created by Vitalii on 17.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    
    static let identifier = "CountryTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CountryTableViewCell", bundle: nil)
    }
    
    func configure(withCountry country: Country) {
        nameLabel.text = country.name
        countryCodeLabel.text = country.alpha2Code + "/" + country.alpha3Code
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont(name: Fonts.futuraMediumTextFont, size: 20)
        countryCodeLabel.font = UIFont(name: Fonts.futuraMediumTextFont, size: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
