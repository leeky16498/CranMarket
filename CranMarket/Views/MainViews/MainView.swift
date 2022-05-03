//
//  FeedView.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 03/05/2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            FeedView()
                .tabItem({
                    Image(systemName: "book")
                    Text("Items")
                })
                .tag(0)
            
            FeedView()
                .tabItem({
                    Image(systemName: "magnifyingglass")
                    Text("Browse")
                })
                .tag(1)
            
            FeedView()
                .tabItem({
                    Image(systemName: "person.fill")
                    Text("Profile")
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
