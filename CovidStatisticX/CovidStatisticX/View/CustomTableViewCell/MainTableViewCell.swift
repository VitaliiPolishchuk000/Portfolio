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
//        totalCasesLabel.text = country.totalCasesText
        chartCasesView.node = MainTableViewCell.createBar(weight: casesDouble / firstArrayElementTotCase * Double(cellWidth), animated: animated, color: color)
    }
    
    static func createBar(weight: Double, animated: Bool, color: Color) -> Node {
       
        var animations: [Animation] = []
        let bar = Shape(
            form: Rect(x: 0, y: 0, w: weight, h: 35),
            fill: LinearGradient(degree: 180, from: color.with(a: 0.5), to: color.with(a: 0.3)),
//            fill: LinearGradient(degree: 180, stops: [Stop(offset: 0, color: Color.red.with(a: finalGradient)), Stop(offset: 1, color: Color.yellow.with(a: 0.3))]),
            place: .scale(sx: 1, sy: 1))
        if animated == true {
            bar.place = .scale(0, 1)
            animations.append(bar.placeVar.animation(to: .move(dx: 0, dy: 0)))
            animations.combine().play()
        }
        return bar
    }
    

    
}
