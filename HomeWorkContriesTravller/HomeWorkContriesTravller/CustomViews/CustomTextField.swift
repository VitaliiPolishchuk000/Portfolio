//
//  MainViewController.swift
//  HomeWorkContriesTravller
//
//  Created by Vitalii on 17.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import UIKit
import iOSDropDown

class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init( coder: aDecoder )
        setUpField()
    }

    private func setUpField() {
        textAlignment           = .center
        tintColor               = .darkGray
        textColor               = .darkGray
        font                    = UIFont(name: Fonts.futuraMediumTextFont, size: 18)
        backgroundColor         = UIColor(white: 1.0, alpha: 0.5)
        autocorrectionType      = .no
        layer.cornerRadius      = 10
        layer.borderWidth       = 2
        layer.borderColor       = UIColor.darkGray.cgColor
        clipsToBounds           = true
        
        let placeholder         = self.placeholder != nil ? self.placeholder! : ""
        let placeholderFont     = UIFont(name: Fonts.futuraMediumTextFont, size: 18)!
        attributedPlaceholder   = NSAttributedString(string: placeholder, attributes:
            [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
             NSAttributedString.Key.font: placeholderFont])
    }
}



