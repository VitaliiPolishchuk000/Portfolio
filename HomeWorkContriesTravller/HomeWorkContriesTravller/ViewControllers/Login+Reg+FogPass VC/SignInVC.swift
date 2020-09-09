//
//  SignInVC.swift
//  HomeWork 11.2
//
//  Created by Vitalii on 06.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth

class SignInVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Class Properties
    var user = UserProfile()
    
    // MARK: - UIViewController events
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground()
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // Keyboard dismiss
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }

    // MARK: - Methods
    @objc func didTapLoginButton() {
        AuthManager.shared.login(email: loginTextField.text, password: passwordTextField.text) { (result) in
            switch result {
            case .success(_):
                self.showAlert(title: kAlertTitleSuccess, message: kAlertMessageAuthSuccess) {
                    
                    // UserDefaults
                    if let userId = Auth.auth().currentUser?.uid {
                        UserDefaults.standard.set(userId, forKey: kCurrentUserKey)
                    }
                    self.performSegue(withIdentifier: "logInSegue", sender: nil)
                }
            case .failure(let error):
                self.showAlert(title: kAlertTitleError, message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func signInAction(_ sender: Any) {
        didTapLoginButton()
    }

}

// MARK: - UITextFieldDelegate
extension SignInVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginTextField: passwordTextField.becomeFirstResponder()
        default: textField.resignFirstResponder()
        }
        return true
    }
}


