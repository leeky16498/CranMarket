//
//  ProfileViewModel.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 05/05/2022.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class ProfileViewModel : ObservableObject {
    
    @Published var userModel : UserModel?
    @Published var userFeeds : [ItemModel] = []
    
    init() {
        fetchCurrentUserInformation()
        fetchMyListingItems()
    }
    
    
    func fetchCurrentUserInformation() {
        
        guard let currentUser = Auth.auth().currentUser else {return}
        
        Firestore.firestore()
            .collection("UsersInfo")
            .document(currentUser.email!)
            .getDocument { [weak self] snapshot, error in
                if let error = error {
                    print("error to get data")
                    return
                }
                
                let data = snapshot?.data()
                
                if let data = data {
                    let email = data["userEmail"] as? String ?? ""
                    let username = data["username"] as? String ?? ""
                    let timestamp = data["timestamp"] as? String ?? ""
                    let imageURL = data["imageURL"] as? String ?? ""
                    
                    self?.userModel = UserModel(email: email, username: username, profileImageUrl: imageURL)
                }

            }
    }
    
    func fetchMyListingItems() {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        Firestore.firestore()
            .collection("UserItems")
            .document(uid)
            .collection(uid)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("error to get data")
                    return
                }
                
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        self.userFeeds = snapshot.documents.map({ d in
                            return ItemModel(id: d.documentID,
                                             category: d["category"] as? String ?? "",
                                             contactInfo: d["contactInfo"] as? String ?? "",
                                             description: d["description"] as? String ?? "",
                                             imageURL: d["imageURL"] as? String ?? "",
                                             price: d["price"] as? String ?? "",
                                             timestamp: d["timestamp"] as? String ?? "",
                                             title: d["title"] as? String ?? "")
                        })
                    }
                }
            }
    }
    
    
}
