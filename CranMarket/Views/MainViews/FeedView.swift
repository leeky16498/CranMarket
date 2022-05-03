//
//  FeedView.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 03/05/2022.
//

import SwiftUI

struct FeedView: View {
    
    @State private var searchText : String = ""
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack {
                    ForEach(1..<10, id: \.self) {post in
                        PostView()
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Items 🎁")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu(content: {
                        menuButton(title: "Room")
                        menuButton(title: "Electronics")
                        menuButton(title: "Fashions")
                        menuButton(title: "Groceries")
                        menuButton(title: "Books")
                        menuButton(title: "Vehicles")
                        menuButton(title: "Sports & Leisure")
                        menuButton(title: "Others")
                    }, label: {
                        Image(systemName: "slider.vertical.3")
                    })
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

extension FeedView {

    private func menuButton(title : String) -> some View {
        Button(action: {
            
        }, label: {
            Text(title)
        })
    }
    
}
