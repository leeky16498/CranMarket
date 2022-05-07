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
    let category, contactInfo, description, imageURL, price, timestamp, title : String
}
