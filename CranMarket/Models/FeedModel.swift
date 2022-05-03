//
//  FeedModel.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 03/05/2022.
//

import Foundation

struct FeedModel : Identifiable, Codable {
    
    var id = UUID()
    var title : String
    var price : Int
    
}
