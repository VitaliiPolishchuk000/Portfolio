//
//  CurrencyViewController.swift
//  HomeWorkContriesTravller
//
//  Created by Vitalii on 02.07.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import Foundation
import UIKit
import iOSDropDown
import Alamofire

class CurrencyViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var firstCurrencyTextField: DropDown!
    @IBOutlet weak var secondCurrencyTextField: DropDown!
    @IBOutlet weak var firstEmountTextField: CustomTextField!
    @IBOutlet weak var secondEmountTextField: CustomTextField!
    @IBOutlet weak var convertButton: CustomButton!
    @IBOutlet weak var firstCurrencyLabel: UILabel!
    @IBOutlet weak var secondCurrencyLabel: UILabel!
    
    // MARK: - Class Properties
    var availableCurrency: Currency!
    
    // MARK: - UIViewController events
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground()
        prepareViews()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Views
    private func prepareViews() {
        
        firstCurrencyTextField.optionArray = Array(availableCurrency.currencies.keys)
        firstCurrencyTextField.textAlignment           = .center
        firstCurrencyTextField.tintColor               = .darkGray
        firstCurrencyTextField.textColor               = .darkGray
        firstCurrencyTextField.font                    =  UIFont(name: Fonts.futuraMediumTextFont, size: 18)
        firstCurrencyTextField.backgroundColor         =  UIColor(white: 1.0, alpha: 0.5)
        firstCurrencyTextField.autocorrectionType      = .no
        firstCurrencyTextField.rowBackgroundColor      =  UIColor(white: 1.0, alpha: 0.5)
        firstCurrencyTextField.layer.cornerRadius      = 10
        firstCurrencyTextField.layer.borderWidth       = 2
        firstCurrencyTextField.layer.borderColor       = UIColor.darkGray.cgColor
        firstCurrencyTextField.clipsToBounds           = true
        firstCurrencyTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: firstCurrencyTextField.frame.height))
        firstCurrencyTextField.leftViewMode = .always
        firstCurrencyTextField.placeholder             = kfirstCurrTextPlacehold
        
        secondCurrencyTextField.optionArray = Array(availableCurrency.currencies.keys)
        secondCurrencyTextField.textAlignment           = .center
        secondCurrencyTextField.tintColor               = .darkGray
        secondCurrencyTextField.textColor               = .darkGray
        secondCurrencyTextField.font                    =  UIFont(name: Fonts.futuraMediumTextFont, size: 18)
        secondCurrencyTextField.backgroundColor         =  UIColor(white: 1.0, alpha: 0.5)
        secondCurrencyTextField.autocorrectionType      = .no
        secondCurrencyTextField.rowBackgroundColor      =  UIColor(white: 1.0, alpha: 0.5)
        secondCurrencyTextField.layer.cornerRadius      = 10
        secondCurrencyTextField.layer.borderWidth       = 2
        secondCurrencyTextField.layer.borderColor       = UIColor.darkGray.cgColor
        secondCurrencyTextField.clipsToBounds           = true
        secondCurrencyTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: secondCurrencyTextField.frame.height))
        secondCurrencyTextField.leftViewMode = .always
        secondCurrencyTextField.placeholder             = ksecondCurrTextPlacehold
        
        firstEmountTextField.text                       = String(1.0000)
        firstEmountTextField.delegate                   = self
        firstEmountTextField.keyboardType               = .numberPad
        
        secondEmountTextField.isUserInteractionEnabled  = false
        
        firstCurrencyLabel.text                         = kFromCurrency
        firstCurrencyLabel.font                         = UIFont(name: Fonts.futuraMediumTextFont, size: 18)
        firstCurrencyLabel.textColor                    = .gray
        
        secondCurrencyLabel.text                        = kToCurrency
        secondCurrencyLabel.font                        = UIFont(name: Fonts.futuraMediumTextFont, size: 18)
        secondCurrencyLabel.textColor                   = .gray
        
        convertButton.addTarget(self, action: #selector(onTapConvertButton), for: .touchUpInside)
        
        firstCurrencyTextField.didSelect{(selectedText , index ,id) in
            self.firstCurrencyLabel.text = self.availableCurrency.currencies["\(selectedText)"]
        }
        
        secondCurrencyTextField.didSelect{(selectedText , index ,id) in
            self.secondCurrencyLabel.text = self.availableCurrency.currencies["\(selectedText)"]
        }
        
    }

    
    // MARK: - Methods
    @objc func onTapConvertButton() {
        
        if Validators.isFilledCurrency(currency1: firstCurrencyTextField.text!, currency2: firstCurrencyTextField.text!) && firstEmountTextField.text!.count > 0{

            fetchConvertCurrency(from: firstCurrencyTextField.text!, to: secondCurrencyTextField.text!, amount: Double(firstEmountTextField.text!)!)

        } else {
            showAlert(title: kAlertTitleWrong, message: kSelectCurrencyMessage)
        }
    }
    
    private func fetchConvertCurrency(from: String, to: String, amount: Double) {
        
        let headers: HTTPHeaders = ["x-rapidapi-host": "currency-converter5.p.rapidapi.com",
                                    "x-rapidapi-key" : "5149ae2853msh263c0299a79f836p1b75acjsn9841e9ac2704"]
        
        NetworkManager.shared.requestApi(stringURL: "https://currency-converter5.p.rapidapi.com/currency/convert?format=json&from=\(from)&to=\(to)&amount=\(amount)", method: .GET, headers: headers) { (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                if let dataCurrency = NetworkHelpers.shared.parseConvertedCurrency(data, codingKey: self.secondCurrencyTextField.text!) {
                    self.secondEmountTextField.text = dataCurrency
//                    self.firstCurrencyLabel.text = self.availableCurrency.currencies["\(self.firstCurrencyTextField.text!)"]
//                    self.secondCurrencyLabel.text = self.availableCurrency.currencies["\(self.secondCurrencyTextField.text!)"]
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

// MARK: - UITextFieldDelegate
extension CurrencyViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: ".0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
    
}
