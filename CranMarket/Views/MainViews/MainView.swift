//
//  FeedView.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 03/05/2022.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var fm = FeedViewModel()
    
    var body: some View {
        TabView {
            FeedView()
                .environmentObject(fm)
                .tabItem({
                    Image(systemName: "book")
                    Text("Items")
                })
                .tag(0)
            
            SavedItemView()
                .tabItem({
                    Image(systemName: "heart.fill")
                    Text("Saved")
                })
                .tag(1)
            
            ProfileView()
                .environmentObject(fm)
                .tabItem({
                    Image(systemName: "person.fill")
                    Text("My Account")
                })
                .tag(2)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
