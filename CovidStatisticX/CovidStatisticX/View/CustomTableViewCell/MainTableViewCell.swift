//
//  MainTableViewCell.swift
//  CovidStatisticX
//
//  Created by Vitalii on 26.10.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import UIKit
import Macaw

final class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var totalCasesLabel: UILabel!
    @IBOutlet weak var chartCasesView: MacawView!
    
    static let identifier = kIdentifireMainTableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: kIdentifireMainTableViewCell, bundle: nil)
    }
    
    func configure(withCountry country: CovidStatisticElement, casesText: String?, casesDouble: Double, firstArrayElementTotCase: Double, cellWidth: CGFloat, chartColor color: Color, animated: Bool){
        countryNameLabel.text = country.countryText
        totalCasesLabel.text = casesText
        chartCasesView.node = MacavChartView.createBar(weight: casesDouble / firstArrayElementTotCase * Double(cellWidth), animated: animated, color: color)
    }
    

    

    
}
