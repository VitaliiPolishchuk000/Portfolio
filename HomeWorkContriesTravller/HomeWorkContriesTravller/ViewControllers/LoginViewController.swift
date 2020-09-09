//
//  ViewController.swift
//  CountriesTraveller
//
//  Created by Steew on 14.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var user = UserProfile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareNextButton()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewDidLayoutSubviews()
    }
    
    func prepareView() {
        firstNameField.placeholder = kEnterFirstName
        lastNameField.placeholder = kEnterLastName
        emailField.placeholder = kEnterEmail
        view.backgroundColor = UIColor.systemOrange
    }
    
    func prepareNextButton() {
        nextButton.setTitle(kNextButtonTitle, for: .normal)
        nextButton.setTitleColor(UIColor.black, for: .normal)
        nextButton.layer.cornerRadius = 0.5 * nextButton.frame.size.width
        nextButton.clipsToBounds = true
        nextButton.backgroundColor = UIColor.blue
        
        nextButton.addTarget(self, action: #selector(onTapButtonNext), for: .touchUpInside)
    }
    
    @objc func onTapButtonNext() {
        if Validators.isValidNameField(name: firstNameField.text!) && Validators.isValidNameField(name: lastNameField.text!) &&
            Validators.isValidEmail(emailField.text) {
            user.firstName = firstNameField.text!
            user.lastName = lastNameField.text!
            user.email = emailField.text!
            onSecondScreen()
        } else {
            self.showAlert(title: kAlertTitleWrong, message: kAlertMessageWrong)
        }
    }
    
    func onSecondScreen() {
        if let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DateViewController") as? DateViewController{
            vc.user = user
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

