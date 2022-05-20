//
//  FeedViewModel.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 03/05/2022.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

class FeedViewModel : ObservableObject {
    
    @Published var feeds : [ItemModel] = [] {
        didSet {
            self.fetchItems()
        }
    }
    
    @Published var savedFeeds : [ItemModel] = [] {
        didSet {
            self.fetchSavedItems()
        }
    }
    
    init() {
        fetchItems()
        fetchSavedItems()
    }
    
    func deleteItems(item : ItemModel) {
        Firestore.firestore()
            .collection("Wholeitems")
            .document(item.id!)
            .delete()
    }
    
    func deleteSavedItem(item : ItemModel) {
        Firestore.firestore()
            .collection("Saveditems")
            .document(item.id!)
            .delete()
    }
    
    func storeSavedItemInformation(title : String, description : String, category : String, contactInfo : String, price : String, imageUrls : [String], timeStamp : Date = Date(), saved : Bool = false, seller : String, completion : @escaping (_ result : Bool) -> ()) {
        
        let uid = AuthService.instance.makeUid()
        
        guard let userData = ["title": title, "description" : description, "category" : category, "price" : price, "imageURL" : imageUrls, "timestamp" : timeStamp, "contactInfo" : contactInfo, "saved" : saved, "seller" : uid] as? [String : Any] else { return }
        
        Firestore.firestore()
            .collection("Saveditems")
            .document(uid)
            .collection(uid)
            .document(UUID().uuidString)
            .setData(userData) { error in
                if let error = error {
                    print("Error to save whole Data")
                    completion(false)
                    return
                }
                print("Success to save whole data")
                completion(true)
        }
    }
    
    func fetchItems() {
        Firestore.firestore()
            .collection("Wholeitems")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("error to get data")
                    return
                }
                
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.feeds = snapshot.documents.map({ d in
                            return ItemModel(id: d.documentID,
                                             category: d["category"] as? String ?? "",
                                             contactInfo: d["contactInfo"] as? String ?? "",
                                             description: d["description"] as? String ?? "",
                                             price: d["price"] as? String ?? "",
                                             timestamp: d["timestamp"] as? String ?? "",
                                             title: d["title"] as? String ?? "",
                                             saved : d["saved"] as? Bool ?? false,
                                             seller: d["seller"] as? String ?? "",
                                             imageURL: d["imageURL"] as? [String] ?? []
                            )
                        })
                    }
                }
            }
    }
    
    func fetchSavedItems() {
        
        let uid = AuthService.instance.makeUid()
        
        Firestore.firestore()
            .collection("Saveditems")
            .document(uid)
            .collection(uid)
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("error to get data")
                    return
                }
                
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.savedFeeds = snapshot.documents.map({ d in
                            return ItemModel(id: d.documentID,
                                             category: d["category"] as? String ?? "",
                                             contactInfo: d["contactInfo"] as? String ?? "",
                                             description: d["description"] as? String ?? "",
                                             price: d["price"] as? String ?? "",
                                             timestamp: d["timestamp"] as? String ?? "",
                                             title: d["title"] as? String ?? "",
                                             saved : d["saved"] as? Bool ?? false,
                                             seller: d["seller"] as? String ?? "",
                                             imageURL: d["imageURL"] as? [String] ?? []
                            )
                        })
                    }
                }
            }
    }
}
