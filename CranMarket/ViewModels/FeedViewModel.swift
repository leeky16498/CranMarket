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
    
    init() {
        fetchItems()
        print(feeds)
    }
    
    func deleteItems(item : ItemModel) {
        Firestore.firestore()
            .collection("Wholeitems")
            .document(item.id!)
            .delete()
    }
    
    func updateItem(item : ItemModel) {
        let a = Firestore.firestore()
            .collection("Wholeitems")
            .document(item.id!)
            .updateData([
                "saved" : item.saved ? false : true
            ])
    }
    
    func fetchItems() {
        Firestore.firestore()
            .collection("Wholeitems")
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
}
