//
//  ContentView.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 03/05/2022.
//

import SwiftUI
import AuthenticationServices

struct HomeView: View {
    
    var body: some View {
        NavigationView {
            VStack(spacing : 20) {
                HStack {
                    VStack(alignment : .leading) {
                        Text("Welcome to")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("CranMarket")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                }
                .padding()
                
                Text("This is the application for the students and families who want to sell and buy some second use things! Start it right now!")
                    .padding()
                
                VStack(spacing : 0) {
                    appleSignInButton
                    googleSignInButton
                    emailSignInButton
                }
 
            }//vst
        }//nav
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView {
    
    @ViewBuilder
    private var appleSignInButton : some View {
        SignInWithAppleButton(.continue) { (request) in
            request.requestedScopes = [.email, .fullName]
        } onCompletion: { (result) in
            switch result {
            case .success(let auth):
                switch auth.credential {
                case let credential as ASAuthorizationAppleIDCredential:
                    let userID = credential.user
                    let email = credential.email
                    let firstName = credential.fullName?.givenName
                    let lastName = credential.fullName?.familyName
                default:
                    break
                }
                break
            case .failure(let error):
                break
            }
        }
        .shadow(color: .gray.opacity(0.2), radius: 10, x: 1, y: 1)
        .frame(height : 60)
        .padding()
    }
    
    @ViewBuilder
    private var emailSignInButton : some View {
        Button(action: {
            
        }, label: {
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.white)
                Text("Sign in with E-mail")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .padding()
            .frame(height : 60)
            .frame(maxWidth : .infinity)
            .background(.blue)
            .cornerRadius(6)
            .padding()
        })
        .shadow(color: .gray.opacity(0.2), radius: 10, x: 1, y: 1)
    }
    
    @ViewBuilder
    private var googleSignInButton : some View {
        Button(action: {
            GoogleSignIn.instance.googleSignIn()
        }, label: {
            HStack {
                Image("googlemark")
                    .resizable()
                    .scaledToFit()
                Text("Continue with Google")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
            }
            .padding()
            .frame(height : 60)
            .frame(maxWidth : .infinity)
            .background(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.black, lineWidth: 1)
            )
            .padding()
        })
        .shadow(color: .gray.opacity(0.2), radius: 10, x: 1, y: 1)
    }
}
