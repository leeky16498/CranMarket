//
//  ImageViewModel.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 10/05/2022.
//

import Foundation
import SwiftUI
import Combine

class ImageViewModel : ObservableObject {
    
    @Published var image : UIImage?
    @Published var isLoading : Bool = false
    
    private let item : ItemModel
    private let dataService : ImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(item : ItemModel) {
        self.item = item
        self.dataService = ImageService(item: item)
        self.isLoading = true
        addSubscriber()
    }
    
    private func addSubscriber() {
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
