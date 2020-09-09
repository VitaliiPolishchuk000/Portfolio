//
//  MainViewController.swift
//  HomeWorkContriesTravller
//
//  Created by Vitalii on 17.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import UIKit
import Firebase
import iOSDropDown

class UserProfileViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var firstNameField: CustomTextField!
    @IBOutlet weak var lastNameField: CustomTextField!
    @IBOutlet weak var nextButton: CustomButton!
    @IBOutlet weak var genderDropDown: DropDown!
    @IBOutlet weak var timeZoneDropDown: DropDown!
    @IBOutlet weak var bornDateTextField: CustomTextField!
    
    // MARK: - Class Properties
    var genderArray = ["Male", "Female", "Other"]
    private let datePicker = UIDatePicker()
    
    var user = UserProfile()
    var selectedTF: UITextField? = nil
    
    // MARK: - UIViewController events
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bornDateTextField.delegate = self
        
        setBackground()
        prepareView()
        prepareNextButton()
        prepareGenderDropDown()
        prepareTimeZoneDropDown()
        createDatePicker()
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewDidLayoutSubviews()
        addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Methods
    func prepareView() {
        firstNameField.placeholder = kEnterFirstName
        lastNameField.placeholder = kEnterLastName
        genderDropDown.placeholder = kGenderDropDown
        timeZoneDropDown.placeholder = kTimeZoneDropDown
        bornDateTextField.placeholder = kBornDateSelect
        nextButton.setTitle(kNextButtonTitle, for: .normal)
    }
    
    func prepareGenderDropDown() {
        genderDropDown.optionArray = genderArray
        genderDropDown.textAlignment           = .center
        genderDropDown.tintColor               = .darkGray
        genderDropDown.textColor               = .darkGray
        genderDropDown.font                    =  UIFont(name: Fonts.futuraMediumTextFont, size: 18)
        genderDropDown.backgroundColor         =  UIColor(white: 1.0, alpha: 0.5)
        genderDropDown.autocorrectionType      = .no
        genderDropDown.rowBackgroundColor      =  UIColor(white: 1.0, alpha: 0.5)
        genderDropDown.layer.cornerRadius      = 10
        genderDropDown.layer.borderWidth       = 2
        genderDropDown.layer.borderColor       = UIColor.darkGray.cgColor
        genderDropDown.clipsToBounds           = true
        genderDropDown.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: genderDropDown.frame.height))
        genderDropDown.leftViewMode = .always
//        genderDropDown.didSelect{(selectedText , index ,id) in
//            self.genderDropDown.text = "Selected String: \(selectedText) \n index: \(index)"
//        }
    }
    
    func prepareTimeZoneDropDown() {
        timeZoneDropDown.optionArray = createTimeZoneArray()
        timeZoneDropDown.textAlignment           = .center
        timeZoneDropDown.tintColor               = .darkGray
        timeZoneDropDown.textColor               = .darkGray
        timeZoneDropDown.font                    =  UIFont(name: Fonts.futuraMediumTextFont, size: 18)
        timeZoneDropDown.backgroundColor         =  UIColor(white: 1.0, alpha: 0.5)
        timeZoneDropDown.autocorrectionType      = .no
        timeZoneDropDown.rowBackgroundColor      =  UIColor(white: 1.0, alpha: 0.5)
        timeZoneDropDown.layer.cornerRadius      = 10
        timeZoneDropDown.layer.borderWidth       = 2
        timeZoneDropDown.layer.borderColor       = UIColor.darkGray.cgColor
        timeZoneDropDown.clipsToBounds           = true
        timeZoneDropDown.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: timeZoneDropDown.frame.height))
        timeZoneDropDown.leftViewMode = .always
//        timeZoneDropDown.didSelect{(selectedText , index ,id) in
//            self.genderDropDown.text = "Selected String: \(selectedText) \n index: \(index)"
//        }
    }
    
    private func createDatePicker() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))

        let toolbar = UIToolbar()
        toolbar.backgroundColor = .systemYellow
        toolbar.setItems([doneButton], animated: true)
        toolbar.sizeToFit()
        
        bornDateTextField.inputAccessoryView = toolbar
        bornDateTextField.inputView = datePicker
        datePicker.datePickerMode = .date
        
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.year = -16
        let maxDate = calendar.date(byAdding: components, to: Date())
        components.year = -100
        let minDate = calendar.date(byAdding: components, to: Date())
        datePicker.maximumDate = maxDate
        datePicker.minimumDate = minDate
        
        bornDateTextField.inputView?.backgroundColor = Colors.peachColor
    }
    
    @objc private func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.dateFormat = "dd.MM.yyyy"
        bornDateTextField.text = formatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    func createTimeZoneArray() -> [String] {
        
        let arrayOfTimeZoneId : [String] = TimeZone.knownTimeZoneIdentifiers
        var arrayOffsetUTC : [String] = []
        var arrayOfTimeZone : [String] = []
        
        for index in 0..<arrayOfTimeZoneId.count {
            let timeZone = TimeZone(identifier: "\(TimeZone.knownTimeZoneIdentifiers[index])")
            arrayOffsetUTC.append((timeZone?.offsetInHours())!)
        }

        for index in 0..<arrayOfTimeZoneId.count {
            arrayOfTimeZone.append("\(arrayOffsetUTC[index]) \(arrayOfTimeZoneId[index])")
        }
        
        return arrayOfTimeZone
    }
    
    func prepareNextButton() {
        nextButton.addTarget(self, action: #selector(onTapButtonNext), for: .touchUpInside)
    }
    
    @objc func onTapButtonNext() {
        if Validators.isValidNameField(name: firstNameField.text!) && Validators.isValidNameField(name: lastNameField.text!) && Validators.isFilled(gender: genderDropDown.text!, bornDate: bornDateTextField.text!, timeZone: timeZoneDropDown.text!) {
            user.firstName = firstNameField.text!
            user.lastName = lastNameField.text!
            user.gender = genderDropDown.text!
            user.bornDate = bornDateTextField.text!
            user.timeZone = timeZoneDropDown.text!
            onSecondScreen()
        } else {
            self.showAlert(title: kAlertTitleWrong, message: kAlertMessageWrong)
        }
    }
    
    func onSecondScreen() {
        if let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AdressPhoneViewController") as? AdressPhoneViewController {
            vc.user = user
            if let nc = navigationController {
                nc.pushViewController(vc, animated: true)
            }
        }
    }

}

// MARK: - UITextFieldDelegate

extension UserProfileViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.selectedTF = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.selectedTF = nil
    }
    
}

// MARK: - Keyboard Notifications

extension UserProfileViewController {
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(UserProfileViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UserProfileViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        
        var shouldMoveViewUp = false
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {

          return
        }

        if let selectedTF = selectedTF {
            let bottomOfTextField = selectedTF.convert(selectedTF.bounds, to: self.view).maxY;
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            if bottomOfTextField > topOfKeyboard {
              shouldMoveViewUp = true
            }
        }

          if(shouldMoveViewUp) {
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        self.view.frame.origin.y = 0
    }

}
