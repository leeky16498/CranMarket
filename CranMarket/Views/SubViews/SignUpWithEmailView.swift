//
//  SignUpView.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 03/05/2022.
//

import SwiftUI
import UIKit

struct SignUpWithEmailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm = SignUpWithEmailViewModel()
    
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var userName : String = ""
    @State private var selectedImage : UIImage?
    @State private var showOneImagePicker : Bool = false
    @State private var imagePickerMode : UIImagePickerController.SourceType = .photoLibrary
    @State private var showLoginAndSignUpView : Bool = false
    @Binding var showMainView : Bool
    
    
    var body: some View {
            NavigationView {
                ZStack{
                    if vm.loading {
                        ProgressView()
                    } else {
                        ScrollView {
                            VStack(alignment : .center) {
                                Button(action: {
                                    showOneImagePicker.toggle()
                                }, label: {
                                    if let selectedImage = selectedImage {
                                        Image(uiImage: selectedImage)
                                            .resizable()
                                            .foregroundColor(.gray.opacity(0.3))
                                            .frame(width : 100, height : 100)
                                            .clipShape(Circle())
                                            .overlay(
                                                Circle()
                                                    .stroke(.gray, lineWidth: 2)
                                            )
                                            .padding()
                                    } else {
                                        Image(systemName: "person.fill")
                                            .resizable()
                                            .foregroundColor(.gray.opacity(0.3))
                                            .frame(width : 100, height : 100)
                                            .clipShape(Circle())
                                            .overlay(
                                                Circle()
                                                    .stroke(.gray, lineWidth: 2)
                                            )
                                            .overlay(
                                                Text("select Image")
                                                    .font(.headline)
                                                    .fontWeight(.bold)
                                                ,alignment: .center
                                            )
                                            .padding()
                                    }
                                })
                                .sheet(isPresented: $showOneImagePicker) {
                                    OneImagePicker(imageSelected: $selectedImage, sourceType: $imagePickerMode)
                                }
                                
                                textFieldStyle(title: "E-mail", bindingText: $email)
                                textFieldStyle(title: "Password", bindingText: $password)
                                textFieldStyle(title: "User name", bindingText: $userName)
                                
                                Button(action: {
                                    if let selectedImage = selectedImage {
                                        vm.storeImageWithUrl(image: selectedImage) { url in
                                            vm.storeUserInformation(email: self.email, username: self.userName, imageUrl: url) { result in
                                                if result {
                                                    AuthService.instance.signUpWithEmail(email: self.email, password: self.password) { result in
                                                        showLoginAndSignUpView.toggle()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }, label: {
                                    Text("Sign Up")
                                        .font(.title3.bold())
                                        .foregroundColor(.white)
                                        .frame(maxWidth : .infinity)
                                        .frame(height : 60)
                                        .background(.blue)
                                        .cornerRadius(12)
                                        .shadow(color: .gray.opacity(0.2), radius: 12, x: 1, y: 1)
                                })
                                .fullScreenCover(isPresented: $showLoginAndSignUpView) {
                                    LogInAneSignUpView()
                                }
                            }//vst
                            .padding()
                            
                            
                        .navigationTitle("Sign Up ")
                        .navigationBarTitleDisplayMode(.large)
                    }
                }
            }
        }
    }
}

//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView(showMainView: $showMainView)
//    }
//}

extension SignUpWithEmailView {
    
    private func textFieldStyle(title : String, bindingText : Binding<String>) -> some View {
        VStack {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
            }
            .padding(.vertical, 4)
            
            TextField(title, text: bindingText)
                .autocapitalization(.none)
            
            Divider()
        }
        .padding(.vertical)
    }
}
