//
//  GoogleSignIn.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 03/05/2022.
//

import Foundation
import GoogleSignIn
import Firebase

class GoogleSignIn {
    
    static let instance = GoogleSignIn()
    
    var isSignedIn : Bool = false
    
    func googleSignIn(completion : @escaping (_ result : Bool) -> ()) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {return}
        
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController()) { [weak self] user, error in
            
            if let error = error {
                print(error.localizedDescription)
              return
            }

            guard
              let authentication = user?.authentication,
              let idToken = authentication.idToken
            else {
              return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)

            //Firebase Auth
            
            Auth.auth().signIn(with: credential) { [weak self] result, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(false)
                    return
                }
                
                guard let user = result?.user else {return}
                print("\(user.displayName) success")
                completion(true)
            }
        }
    }
    
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
    
}
