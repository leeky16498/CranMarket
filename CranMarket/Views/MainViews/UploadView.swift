//
//  UploadView.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 04/05/2022.
//

import SwiftUI
import UIKit
import PhotosUI

struct UploadView: View {
    
    @State private var title : String = ""
    @State private var description : String = ""
    @State private var price : String = ""
    @State private var category : String = ""
    @State private var showImagePicker : Bool = false
    @State private var selectedImages : [UIImage] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing : 20) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Button(action: {
                                showImagePicker.toggle()
                            }, label: {
                                VStack(alignment : .center) {
                                    Image(systemName: "camera.fill")
                                        .foregroundColor(.white)
                                        .font(.largeTitle)
                                    Text("Add photo")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .padding(.top, 10)
                                }
                                .padding()
                                .background(.blue)
                                .cornerRadius(12)
                                .shadow(color: .gray.opacity(0.3), radius: 12, x: 3, y: 3)
                            })
                            .sheet(isPresented: $showImagePicker, content: {
                               ImagePicker(images: $selectedImages, picker: $showImagePicker)
                            })
                            
                            ForEach(selectedImages, id : \.self) {
                                Image(uiImage: $0)
                                    .resizable()
                                    .frame(width : 100, height : 100)
                                    .cornerRadius(12)
                            }
                        }
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
                        .autocapitalization(.none)
                    
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
                        .autocapitalization(.none)
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
                                    category = "Room"
                                }, label: {
                                    Text("Room")
                                })
                                
                                Button(action: {
                                    category = "Electronics"
                                }, label: {
                                    Text("Electronics")
                                })
                            }, label: {
                                if category.isEmpty {
                                    Image(systemName: "chevron.right")
                                        .padding()
                                } else {
                                    Text(category)
                                }
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
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Upload My Item")
                            .foregroundColor(.white)
                            .font(.title3.bold())
                            .frame(maxWidth : .infinity)
                            .frame(height : 60)
                            .background(.blue)
                            .cornerRadius(12)
                            .padding()
                    })
                    
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
