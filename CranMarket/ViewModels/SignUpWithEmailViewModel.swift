//
//  SignUpWithEmailViewModel.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 05/05/2022.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseStorageSwift
import UIKit

class SignUpWithEmailViewModel : ObservableObject {
    
    @Published var loading : Bool = false
    
    func storeImageWithUrl(image : UIImage, completion : @escaping (_ url : URL) -> ()) {
        
        self.loading = true
        
        let ref = Storage.storage().reference(withPath: UUID().uuidString)
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {return}
        
        ref.putData(imageData, metadata: nil) { metaData, error in
            
            if let error = error {
                print("failed to push image cause of error")
                return
            }
            
            ref.downloadURL { url, error in
                if let error = error {
                    print("error to make url")
                    return
                }
                guard let url = url else {return}
                completion(url)
            }
        }
    }
    
    func storeUserInformation(email : String, username : String, imageUrl : URL, timeStamp : Date = Date(), completion : @escaping (_ result : Bool) -> ()) {
        
        guard let userData = ["userEmail" : email, "username" : username, "imageURL" : imageUrl.absoluteString, "timestamp" : timeStamp] as? [String : Any] else { return }
        
        Firestore.firestore()
            .collection("UsersInfo")
            .document(email)
            .setData(userData) { error in
                if let error = error {
                    print("Error to save whole Data")
                    completion(false)
                    return
                }
                
            self.loading = false
            print("Success to save user information")
            completion(true)
                
            }
    }
}
