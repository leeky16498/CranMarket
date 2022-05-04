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
        
        let uid = AuthService.instance.makeUid()
        let ref = Storage.storage().reference(withPath: uid)
        
        print(image)
        print(uid)
        print(ref)
        
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
    
    func storeItemInformation(uid : String, title : String, description : String, category : String, price : Double, imageUrl : URL) {

        let uid = AuthService.instance.makeUid()
        
        guard let userData = ["uid" : uid, "title": title, "description" : description, "category" : category, "price" : price, "imageURL" : imageUrl.absoluteString] as? [String : Any] else { return }
        
        Firestore.firestore().collection("Items").document(uid).setData(userData) { error in
            if let error = error {
                print("Error to save userData")
                
                return
            }
            
            self.loading = false

            print("Success to save user data")
        }
    }
    
}
