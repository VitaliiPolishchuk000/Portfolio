//
//  ViewController.swift
//  HomeWorkContriesTravller
//
//  Created by Vitalii on 17.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import UIKit

class CountryInfoViewController: UIViewController {
    

    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alphaCodeLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var timezonesLabel: UILabel!
    
    // MARK: - Class Properties
    var country: Country!
    
    // MARK: - UIViewController events
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        prepareNavigationTitle()
        prepareLabels()
    }
    
    // MARK: - Method

    private func prepareLabels() {
        nameLabel.font = UIFont(name: Fonts.futuraMediumTextFont, size: 30)
        alphaCodeLabel.font = UIFont(name: Fonts.futuraMediumTextFont, size: 30)
        capitalLabel.font = UIFont(name: Fonts.futuraMediumTextFont, size: 30)
        regionLabel.font = UIFont(name: Fonts.futuraMediumTextFont, size: 30)
        populationLabel.font = UIFont(name: Fonts.futuraMediumTextFont, size: 30)
        timezonesLabel.font = UIFont(name: Fonts.futuraMediumTextFont, size: 30)
        
        nameLabel.text = country.name
        alphaCodeLabel.text = country.alpha2Code + " / " + country.alpha3Code
        capitalLabel.text = country.capital
        regionLabel.text = country.region
        populationLabel.text = String(country.population) + " people"
        
        var string = ""
        for zone in country.timezones {
            string += zone + " "
        }
        timezonesLabel.text = string
    }

    private func prepareNavigationTitle() {
        navigationController?.navigationBar.barTintColor = Colors.peachColor
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont(name: Fonts.futuraMediumTextFont, size: 30)!, .foregroundColor: Colors.purple]
        
        if country.name.count > 7 {
            navigationItem.title = country.demonym
        } else {
            navigationItem.title = country.name
        }
        
    }
}

