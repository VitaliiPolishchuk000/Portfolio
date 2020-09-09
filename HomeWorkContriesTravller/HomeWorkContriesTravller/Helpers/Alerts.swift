//
//  MainViewController.swift
//  HomeWorkContriesTravller
//
//  Created by Vitalii on 17.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, completion: @escaping () -> Void = { }) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            completion()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    func showActionSheet(completion: @escaping () -> Void = { }) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let logOutAction = UIAlertAction(title: "Log out", style: .destructive) { (_) in
            completion()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(logOutAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    func showLogoutActionSheet(completion: @escaping () -> Void = { }) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: kActionSheetLogout, style: .destructive) { (_) in
            completion()
        }
        let cancelAction = UIAlertAction(title: kActionSheetCancel, style: .cancel)
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
