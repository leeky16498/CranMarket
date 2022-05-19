//
//  FeedModel.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 03/05/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct ItemModel : Identifiable, Codable {
    @DocumentID var id : String?
    let category, contactInfo, description, price, timestamp, title : String
    var saved : Bool
    let seller : String
    let imageURL : [String]
}
