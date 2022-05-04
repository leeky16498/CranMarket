//
//  UploadView.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 04/05/2022.
//

import SwiftUI
import UIKit

struct UploadView: View {
    
    @State private var title : String = ""
    @State private var description : String = ""
    @State private var price : String = ""
    @State private var showImagePicker : Bool = false
    @State private var selectedImages : [UIImage] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing : 20) {
                    HStack {
                        Button(action: {
                            showImagePicker.toggle()
                        }, label: {
                            VStack {
                                Image(systemName: "camera.fill")
                                    .foregroundColor(.gray)
                                    .font(.largeTitle)
                                Text("Add photo")
                                    .font(.headline)
                                    .padding(.top, 10)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.gray, lineWidth: 1)
                            )
                        })
                        .sheet(isPresented: $showImagePicker, content: {
                           ImagePicker(images: $selectedImages, picker: $showImagePicker)
                        })
                        ScrollView(.horizontal) {
                            ForEach(selectedImages,  id : \.self) { image in
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width : 100, height : 100)
                                    .cornerRadius(12)
                            }
                        }
                        Spacer()
                    }
                        .padding()
                    
                    Divider()
                    
                    HStack {
                        Text("Title")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    TextField("Title", text: $title)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                        .padding(.top, -10)
                    
                    HStack {
                        Text("Description")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    TextEditor(text: $description)
                        .frame(maxWidth : .infinity)
                        .frame(height : UIScreen.main.bounds.height * 0.2)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.gray.opacity(0.2), lineWidth: 1)
                        )
                        .padding(.horizontal)
                        .padding(.top, -10)
                    
                    HStack {
                        Text("Category")
                            .font(.headline)
                        Spacer()
                        Menu(content: {
                            Button(action: {
                                
                            }, label: {
                                Text("Room")
                            })
                        }, label: {
                            Image(systemName: "chevron.right")
                        })
                    }
                    .padding()
                    
                    HStack {
                        Text("Price")
                            .font(.headline)
                        Spacer()
                        TextField("GBP", text: $price)
                            .padding()
                            .frame(width : 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.gray.opacity(0.2), lineWidth: 1)
                            )
                        Text("£")
                    }
                    .padding()
                    
                }
            }
            .navigationTitle("Post item")
        }
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
