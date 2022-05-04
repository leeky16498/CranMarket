//
//  ImagePicker.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 04/05/2022.
//

import SwiftUI
import PhotosUI
import UIKit

struct ImagePicker : UIViewControllerRepresentable {
    
    @Binding var images : [UIImage]
    @Binding var picker : Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 0 // multiple selection
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }

    class Coordinator : NSObject, PHPickerViewControllerDelegate {
        
        var parent : ImagePicker
        
        init(parent : ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            //closing picker
            parent.picker.toggle()
            
            for img in results {
                if img.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    img.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                        guard let image1 = image else {
                            print("error to select images")
                            return
                        }
                        self.parent.images.append(image as! UIImage)
                    }
                } else {
                    print("cant load the images")
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(parent: self)
    }
    
    
    
}
