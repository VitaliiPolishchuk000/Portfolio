//
//  MainViewController.swift
//  HomeWorkContriesTravller
//
//  Created by Vitalii on 17.06.2020.
//  Copyright © 2020 Vitalii Polishchuk. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class FirestoreManager {
    
    // MARK: - Properties
    
    static let shared = FirestoreManager()
    private let dataBase = Firestore.firestore()
    private init() {}
    
    private var usersReference: CollectionReference {
        return dataBase.collection("users")
    }
    
    // MARK: - Methods
    
    func saveProfile(user: UserProfile, userImage: UIImage?, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        self.usersReference.document(user.email).setData(user.representation) { (error) in
            guard let error = error else {
                completion(.success(user))
                return
            }
            completion(.failure(error))
        }
    }
}
