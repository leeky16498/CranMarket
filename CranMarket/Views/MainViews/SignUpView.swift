//
//  SignUpView.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 03/05/2022.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var firstName : String = ""
    @State private var lastName : String = ""
    @State private var userName : String = ""
    @Binding var showMainView : Bool
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment : .leading) {
                    textFieldStyle(title: "E-mail", bindingText: $email)
                    
                    textFieldStyle(title: "Password", bindingText: $password)
                    
                    textFieldStyle(title: "Last name", bindingText: $lastName)
                    
                    textFieldStyle(title: "First name", bindingText: $firstName)
                    
                    textFieldStyle(title: "User name", bindingText: $userName)
                    
                    Button(action: {
                        AuthService.instance.signUpWithEmail(email: email, password: password) { result in
                            if result {
                                presentationMode.wrappedValue.dismiss()
                                showMainView.toggle()
                            } else {
                                print("cannot close the view")
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
                }//vst
                .padding()
                
                
            .navigationTitle("Sign Up ")
            .navigationBarTitleDisplayMode(.large)
            }
        }
    }
}

//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//            SignUpView()
//    }
//}

extension SignUpView {
    
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
