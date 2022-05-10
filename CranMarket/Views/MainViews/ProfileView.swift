//
//  ProfileView.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 05/05/2022.
//

import SwiftUI
import FirebaseAuth
import Kingfisher

struct ProfileView: View {

    @State private var showMainView : Bool = false
    @StateObject var vm = ProfileViewModel()

    var currentUser = Auth.auth().currentUser
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if let currentUser = currentUser {
                        KFImage.url(currentUser.photoURL)
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(.gray.opacity(0.3))
                            .frame(width : 100, height : 100)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(.gray, lineWidth: 2)
                            )
                            .padding()
                            
                    } else {
                        Button(action: {
                            
                        }, label: {
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
                        })
                    }
                    
                    Divider()
                    
                    VStack {
                        HStack {
                            Text("E-mail  :  \(currentUser?.email ?? "")")
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top, 1)
                        
                        HStack {
                            Text("User name  :  \(vm.userModel?.username ?? "")")
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top, 1)
                    }
                    Divider()
                    
                    Button(action: {
                        print("pressed button")
                        AuthService.instance.signOut { result in
                            if result {
                                showMainView.toggle()
                            }
                        }
                    }, label: {
                        Text("Sign Out")
                            .frame(maxWidth : .infinity)
                            .frame(height : 60)
                            .font(.title3.bold())
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(12)
                            .padding()
                    })
                    .fullScreenCover(isPresented: $showMainView) {
                        LogInAneSignUpView()
                    }
                    
                    HStack {
                        Text("My Listing")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    Divider()
                    
                    ScrollView{
//                        VStack {
//                            ForEach(vm.userFeeds) { item in
//                                PostView(item: item)
//                            }
//                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: {
                        
                    }, label: {
                        Image(systemName: "gear")
                    })
                }
            }
            .navigationTitle("My profile")
        }//nav
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
