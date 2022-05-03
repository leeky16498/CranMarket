//
//  FeedViewModel.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 03/05/2022.
//

import Foundation

class FeedViewModel : ObservableObject {
    
    @Published var feeds : [FeedModel] = []
    
}
