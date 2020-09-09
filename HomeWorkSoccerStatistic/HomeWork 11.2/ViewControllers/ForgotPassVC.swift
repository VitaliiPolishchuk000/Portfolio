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
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func sendLetterAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if isValidInputEmail(userEmail: emailTextField.text) {
            
            Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { error in
                let alert = UIAlertController.init(title: "Letter sended", message: "Letter with your password sended to your email", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .default) { _ in
                    self.dismiss(animated: true)
                }
                alert.addAction(action)
                self.present(alert, animated: true)
            }
            
        } else {
            
            let alert = UIAlertController.init(title: "Wrong email", message: nil, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default) { _ in
                
            }
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
    

extension ForgotPassVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


