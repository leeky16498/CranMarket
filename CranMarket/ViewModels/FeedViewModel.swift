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
    
    @Published var feeds : [ItemModel] = []
    
    init() {
        fetchItems()
    }
    
    func fetchItems() {
        
        Firestore.firestore()
            .collection("WholeItems")
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
