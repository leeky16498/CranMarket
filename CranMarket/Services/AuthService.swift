//
//  AuthService.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 03/05/2022.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    static let instance = AuthService()
    
    var isSignIn : Bool = false
    
    func signUpWithEmail(email : String, password : String, completion : @escaping (_ result : Bool) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                print("error to make account")
                completion(false)
            }
            completion(true)
        }
    }
}
