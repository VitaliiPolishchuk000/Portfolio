//
//  MainViewController.swift
//  HomeWorkContriesTravller
//
//  Created by Vitalii on 17.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        backgroundColor     = Colors.purple
        titleLabel?.font    = UIFont(name: Fonts.futuraMediumTextFont, size: 22)
        layer.cornerRadius  = 10
        setTitleColor(.white, for: .normal)
    }
    
    func shake() {
        let shake           = CABasicAnimation(keyPath: "position")
        shake.duration      = 0.1
        shake.repeatCount   = 1
        shake.autoreverses  = false
        
        let fromPoint       = CGPoint(x: center.x - 8, y: center.y)
        let fromValue       = NSValue(cgPoint: fromPoint)
        
        let toPoint         = CGPoint(x: center.x + 8, y: center.y)
        let toValue         = NSValue(cgPoint: toPoint)
        
        shake.fromValue     = fromValue
        shake.toValue       = toValue
        
        layer.add(shake, forKey: "position")
    }
}
