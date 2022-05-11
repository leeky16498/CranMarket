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
                    ForEach(vm.feeds) { item in
                        PostView(item: item)
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Saved Items ❤️")
            .navigationBarTitleDisplayMode(.inline)
            }
        
            .onAppear {
                vm.fetchItems()
            }
    }
}
