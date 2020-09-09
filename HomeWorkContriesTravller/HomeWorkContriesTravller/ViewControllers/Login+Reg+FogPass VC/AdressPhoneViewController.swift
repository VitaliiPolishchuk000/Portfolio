//
//  DateViewController.swift
//  CountriesTraveller
//
//  Created by Steew on 14.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import FlagPhoneNumber

class AdressPhoneViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var phoneNumberTextField: FPNTextField!
    @IBOutlet weak var adressTextField: CustomTextField!
    @IBOutlet weak var NextButton: CustomButton!
    
    // MARK: - Class Properties
    private var listController = FPNCountryListViewController(style: .grouped)
    private var isPhoneValid = false
    var user = UserProfile()
    
    // MARK: - UIViewController events
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        prepareView()
        prepareNextButton()

        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Methods
    func prepareView() {
        
        phoneNumberTextField.placeholder = kEnterPhoneNumber
        phoneNumberTextField.setFlag(key: .UA)
        phoneNumberTextField.delegate = self
        
        adressTextField.placeholder = kEnterAdress
        NextButton.setTitle(kNextButtonTitle, for: .normal)
        
    }
    
    private func prepareListController() {
        
        phoneNumberTextField.displayMode = .list
        listController.setup(repository: phoneNumberTextField.countryRepository)
        listController.didSelect = { [weak self] country in
            self?.phoneNumberTextField.setFlag(countryCode: country.code)
        }
    }
    
    func prepareNextButton() {
          NextButton.addTarget(self, action: #selector(onTapButtonNext), for: .touchUpInside)
      }
      
    @objc func onTapButtonNext() {
        guard Validators.isFilled(address: adressTextField.text, phone: phoneNumberTextField.text) else {
              showAlert(title: kAlertTitleWrong, message: kAlertMessageWrong)
              return
          }
        guard isPhoneValid else {
              showAlert(title: kAlertTitleWrong, message: kAlertMessageWrongPhoneNumber)
              return
          }
        
        user.phone = phoneNumberTextField.text!
        user.adress = adressTextField.text!
        
        onSecondScreen()
      }
      
    func onSecondScreen() {
        if let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController{
                 vc.user = user
                 self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

// MARK: - FPNTextFieldDelegate
extension AdressPhoneViewController: FPNTextFieldDelegate {
    
    func fpnDisplayCountryList() {
        let navigationViewController = UINavigationController(rootViewController: listController)
        listController.title = "Countries"
        self.present(navigationViewController, animated: true)
    }
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        phoneNumberTextField.text = ""
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            isPhoneValid = true
            view.endEditing(true)
        } else {
            isPhoneValid = false
        }
    }
}

