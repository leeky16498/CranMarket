//
//  StoreService.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 04/05/2022.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseStorageSwift
import UIKit

class UploadViewModel : ObservableObject {
    
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
    
    func storeItemInformation(title : String, description : String, category : String, contactInfo : String, price : String, imageUrl : URL, timeStamp : Date = Date(), completion : @escaping (_ result : Bool) -> ()) {
        
        let uid = AuthService.instance.makeUid()
        
        guard let userData = ["title": title, "description" : description, "category" : category, "price" : price, "imageURL" : imageUrl.absoluteString, "timestamp" : timeStamp, "contactInfo" : contactInfo] as? [String : Any] else { return }
        
        Firestore.firestore()
            .collection("WholeItems")
            .document(UUID().uuidString)
            .setData(userData) { error in
                if let error = error {
                    print("Error to save whole Data")
                    completion(false)
                    return
                }
                print("Success to save whole data")
        
                Firestore.firestore()
                    .collection("UserItems")
                    .document(uid)
                    .collection(uid)
                    .document(UUID().uuidString)
                    .setData(userData) { error in
                        if let error = error {
                            print("Error to save userData")
                            completion(false)
                            return
                        }
                        
                    self.loading = false
                    print("Success to save user data")
                    completion(true)
                }
        }
    }
}
