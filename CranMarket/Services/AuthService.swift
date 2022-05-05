//
//  AuthService.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 03/05/2022.
//

import Foundation
import FirebaseAuth
import CoreMedia

class AuthService {
    
    static let instance = AuthService()
    
    func signUpWithEmail(email : String, password : String, completion : @escaping (_ result : Bool) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                print("error to make account")
                completion(false)
                return
            } else {
                print("success to make account")
                completion(true)
            }
        }
    }
    
    func signInWithEmail(email : String, password : String, completion : @escaping (_ result : Bool) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                print("error to sign in with email")
                completion(false)
            } else {
                print("success to sign in with email")
                completion(true)
            }
        }
    }
    
    func makeUid() -> String {
        if let uid = Auth.auth().currentUser?.uid {
            return uid
        }
        return ""
    }
    
    func signOut(completion : (_ result : Bool) -> ()) {
        do {
            try Auth.auth().signOut()
            print("Signout success")
            completion(true)
        } catch {
            print("error to sign out")
            completion(true)
        }
    }
    
}
