//
//  ForgotPassVC.swift
//  HomeWork 11.2
//
//  Created by Vitalii on 06.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth

class ForgotPassVC: UIViewController {
    
    @IBOutlet weak var emailTextField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
// MARK: - IBAction
    @IBAction func sendLetterAction(_ sender: UIButton) {
        AuthManager.shared.remindPassword(email: emailTextField.text) { (result) in
            switch result {
            case .success(_):
                self.showAlert(title: kAlertTitleSuccess, message: kAlertMessageRemindPassSucces) {
                    self.dismiss(animated: true)
                }
            case .failure(let error):
                self.showAlert(title: kAlertTitleError, message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}

// MARK: - UITextFieldDelegate
extension ForgotPassVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


