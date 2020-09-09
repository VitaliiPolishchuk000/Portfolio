//
//  SignUpVC.swift
//  HomeWork 11.2
//
//  Created by Vitalii on 06.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class SignUpVC: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var emailRegTextField: CustomTextField!
    @IBOutlet weak var passwordRegTextField: CustomTextField!
    @IBOutlet weak var passwordConfRegTextField: CustomTextField!
    
    // MARK: - Class Properties
    var user = UserProfile()
    var userImage: UIImage!
    
    // MARK: - UIViewController events
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailRegTextField.delegate = self
        passwordRegTextField.delegate = self
        passwordConfRegTextField.delegate = self
        
        setBackground()
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Methods
    @objc func didTapSignUpButton() {
        
        AuthManager.shared.register(email: emailRegTextField.text, password: passwordRegTextField.text, confirmPassword: passwordConfRegTextField.text) { (result) in
            switch result {
                
            case .success(let user):
                
                self.saveUserImage(currentUser: user)
                
                self.showAlert(title: kAlertTitleSuccess, message: kAlertMessageRegistrationSuccess) {
                    let vc = self.storyboard?.instantiateViewController(identifier: "LogInVCID") as! SignInVC
                    vc.modalTransitionStyle = .flipHorizontal
                    vc.modalPresentationStyle = .fullScreen
                    vc.user.email = user.email!
                    self.present(vc, animated: true)
                    
                }
                
            case .failure(let error):
                self.showAlert(title: kAlertTitleError, message: error.localizedDescription)
            }
        }
    }
    
    private func saveAllUserData() {
         FirestoreManager.shared.saveProfile(user: user, userImage: userImage) { (result) in
             switch result {
             case .success(_):
                 self.showAlert(title: kAlertTitleSuccess, message: kAlertMessageRegistrationSuccess) {
                 }
             case .failure(let error):
                 self.showAlert(title: kAlertTitleError, message: error.localizedDescription)
             }
         }
     }
     
     private func saveUserImage(currentUser: User) {

        user.email = currentUser.email!
         
        StorageManager.shared.upload(userPhoto: userImage, userId: user.email) { (result) in
             switch result {
             case .success(let url):
                 self.user.avatarStringURL = url.absoluteString
                 self.saveAllUserData()
             case .failure(let error):
                 self.showAlert(title: kAlertTitleError, message: error.localizedDescription)
             }
         }
     }
    
    @IBAction func registerAction(_ sender: Any) {
        
        
        didTapSignUpButton()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

// MARK: - UITextFieldDelegate
extension SignUpVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailRegTextField: passwordRegTextField.becomeFirstResponder()
        case passwordRegTextField: passwordConfRegTextField.becomeFirstResponder()
        default: textField.resignFirstResponder()
        }
        return true
    }
}
