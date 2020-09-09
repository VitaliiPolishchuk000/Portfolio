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

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    // Keyboard dismiss
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }
    
    func showPopup(isSuccess: Bool) {
         
       let successMessage = "User was sucessfully logged in."
       let errorMessage = "Login or password uncorrect try again"
         
       let alert = UIAlertController(title: isSuccess ? "Success": "Error", message: isSuccess ? successMessage: errorMessage, preferredStyle: UIAlertController.Style.alert)
         
         let action = isSuccess ? (UIAlertAction(title: "Done", style: UIAlertAction.Style.default) { _ in
             
            // UserDefaults
             if let userId = Auth.auth().currentUser?.uid {
                 UserDefaults.standard.set(userId, forKey: Constants.UserDefaults.currentUser)
             }
             
             self.performSegue(withIdentifier: "logInSegue", sender: nil)
             
         }) : (UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
         
       alert.addAction(action)
         self.display(alertController: alert)
     }

    @objc func didTapLoginButton() {
        let loginManager = FirebaseAuthManager()
    guard let email = loginTextField.text, let password = passwordTextField.text else { return }
        loginManager.signIn(email: email, pass: password) {[weak self] (success) in
            self?.showPopup(isSuccess: success)
        }
    }
    
    func display(alertController: UIAlertController) {
         self.present(alertController, animated: true, completion: nil)
     }
    
    @IBAction func signInAction(_ sender: Any) {
        didTapLoginButton()
    }

}


extension SignInVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginTextField: passwordTextField.becomeFirstResponder()
        default: textField.resignFirstResponder()
        }
        return true
    }
}


