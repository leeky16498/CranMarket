//
//  ImageFileManager.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 10/05/2022.
//

import Foundation
import SwiftUI

class ImageFileManager {
    
    static let instance = ImageFileManager()
    
    private init() {
        
    }
    
    func saveImage(image : UIImage, folderName : String, imageName : String) {
        createFolderIfNeeded(folderName: folderName)
        
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName) else {return}
        
        do {
            try data.write(to: url)
        } catch let error {
            print("error to save images")
        }
    }
    
    func getImages(imageName : String, folderName : String) -> UIImage? {
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path) else {return nil}
        
        return UIImage(contentsOfFile: url.path)
              
    }
    
    private func createFolderIfNeeded(folderName : String) {
        guard let url = getURLForFolder(folderName: folderName) else {return}
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error to make directory")
            }
        }
    }
    
    private func getURLForFolder(folderName : String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return nil}
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(imageName : String, folderName : String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {return nil}
        return folderURL.appendingPathComponent(imageName + ".png")
    }
    
}
