//
//  TranslatedImageViewController.swift
//  HomeWorkContriesTravller
//
//  Created by Vitalii on 02.07.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class TranslatedImageViewController: UIViewController {
        
    // MARK: - IBOutlets
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Class Properties
    var image: UIImage!

    // MARK: - UIViewController events
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        prepareView()
        getTextForImage()
    }
    
    func prepareView() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        textLabel.text = ""
        textLabel.font = UIFont(name: Fonts.futuraMediumTextFont, size: 16)
        textLabel.minimumScaleFactor = 0.1
        textLabel.backgroundColor = UIColor(white: 1, alpha: 0.5)
        textLabel.numberOfLines = 0
    }
    
    func getTextForImage() {
        
        NetworkManager.shared.convertImageToText(image: image) { (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                guard let text = NetworkHelpers.shared.parseText(data) else { return }
                
                NetworkManager.shared.getTranslatedText(text: text) { (result) in
                    switch result {
                        
                    case .success(let data):
                        guard let data = data else { return }
                        guard let text = NetworkHelpers.shared.parseTranslatedText(data) else { return }
                        
                        DispatchQueue.main.async {
                            self.navigationItem.hidesBackButton = false
                            self.activityIndicator.startAnimating()
                            self.activityIndicator.isHidden = true
                            self.textLabel.text = text
                        }
                        
                    case .failure(let error):
                        self.showAlert(title: kAlertTitleError, message: error.localizedDescription)
                    }
                }

            case .failure(let error):
                self.showAlert(title: kAlertTitleError, message: error.localizedDescription)
            }
        }
    }
}

