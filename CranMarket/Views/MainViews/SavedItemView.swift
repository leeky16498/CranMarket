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
                    ForEach(vm.feeds.filter({$0.saved == true})) { item in
                        SavedPostView(item: item)
                            .environmentObject(vm)
                    }
                }
            }
            .navigationTitle("Saved Items ❤️")
            .onAppear {
                vm.fetchItems()
            }
        }
    }
}
