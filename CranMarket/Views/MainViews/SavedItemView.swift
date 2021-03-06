//
//  SavedItemView.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 05/05/2022.
//

import SwiftUI

struct SavedItemView: View {
    
    @State private var searchText : String = ""
    @State private var showUploadView : Bool = false
    @State private var showHalfSheet : Bool = false
    @StateObject var vm = FeedViewModel()
    
    @State private var selectedItem : ItemModel?
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack {
                    ForEach(vm.savedFeeds) { item in
                        NavigationLink(destination: {
                            DescriptionView(item: item)
                        }, label: {
                            SavedPostView(item: item)
                                .environmentObject(vm)
                        })
                    }
                }
            }
            .navigationTitle("Saved Items")
            .onAppear {
                vm.fetchSavedItems()
            }
        }
    }
}
