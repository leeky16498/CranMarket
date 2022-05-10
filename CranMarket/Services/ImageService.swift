//
//  ImageService.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 10/05/2022.
//
import Foundation
import SwiftUI
import Combine


class ImageService {
    
    @Published var image : UIImage? = nil

    private let item : ItemModel
    private var imageSubscription : AnyCancellable?
    private let fileManager = ImageFileManager.instance
    private let folderName = "items_Images"
    private let imageName : String
    
    init(item : ItemModel) {
        self.item = item
        self.imageName = item.id ?? ""
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImages(imageName: item.id!, folderName: folderName) {
            image = savedImage
            print("Get image from fileManager")
        } else {
            downloadImage()
            print("Download Images!")
        }
    }
    
    private func downloadImage() {
        print("downloading Images!")
        guard let url = URL(string: item.imageURL) else {return}
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let downloadImage = returnedImage else {return}
                self.image = returnedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadImage, folderName: self.folderName , imageName: self.imageName)
            })
    }
    
}
