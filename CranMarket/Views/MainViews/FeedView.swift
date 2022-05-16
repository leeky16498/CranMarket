//
//  FeedView.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 03/05/2022.
//

import SwiftUI

struct FeedView: View {
    
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
                        NavigationLink(destination: {
                            DescriptionView(item: item)
                        }, label: {
                            PostView(item: item)
                        })
                    }
                }
            }
            
            .searchable(text: $searchText)
            .navigationTitle("Whole Items 🎁")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Menu(content: {
                            Button(action: {
                                
                            }, label: {
                                Text("Rooms")
                            })
                        }, label: {
                            Image(systemName: "slider.vertical.3")
                        })
                        
                        NavigationLink(destination: {
                            UploadView()
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                }
            }
            .onAppear {
                vm.fetchItems()
            }
        }//nav
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
