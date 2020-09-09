//
//  MainViewController.swift
//  HomeWorkContriesTravller
//
//  Created by Vitalii on 17.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import UIKit
import FirebaseUI

class AuthManager {
    
    // MARK: - Properties
    
    static let shared = AuthManager()
    private let auth = Auth.auth()
    
    // MARK: - Private Method
    
    func login(email: String?, password: String?, completion: @escaping (Result<User, Error>) -> Void) {
        
        guard let email = email, let password = password else {
            completion(.failure(AuthError.notFilled))
            return
        }
        
        auth.signIn(withEmail: email, password: password) { (result, error) in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
    
    func register(email: String?, password: String?, confirmPassword: String?, completion: @escaping (Result<User, Error>) -> Void) {
        
        guard Validators.isFilled(email, password, confirmPassword) else {
            completion(.failure(AuthError.notFilled))
            return
        }
        
        guard password == confirmPassword else {
            completion(.failure(AuthError.passwordsNotMatched))
            return
        }
        
        guard Validators.isValidInputEmail(email) else {
            completion(.failure(AuthError.invalidEmail))
            return
        }
        
        auth.createUser(withEmail: email!, password: password!) { (result, error) in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
    
    func remindPassword(email: String?, completion: @escaping (Result<Bool, Error>) -> Void) {

        guard let email = email, Validators.isValidInputEmail(email) else {
            completion(.failure(AuthError.invalidEmail))
            return
        }
        
        auth.sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
}

