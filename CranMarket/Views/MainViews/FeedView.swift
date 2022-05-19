//
//  FeedView.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 03/05/2022.
//

import SwiftUI

struct FeedView: View {
    
    @EnvironmentObject var vm : FeedViewModel
    @State private var searchText : String = ""
    @State private var showUploadView : Bool = false
    @State private var showHalfSheet : Bool = false
    @State private var selectedItem : ItemModel?
    @State private var selectedFilter : String = ""
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack {
                    ForEach(selectedFilter.isEmpty ? vm.feeds : vm.feeds.filter({$0.category == selectedFilter})) { item in
                        NavigationLink(destination: {
                            DescriptionView(item: item)
                        }, label: {
                            PostView(item: item)
                        })
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Whole Items")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Menu(content: {
                            Button(action: {
                                selectedFilter = "Rooms and Funitures"
                            }, label: {
                                Text("Rooms and Funitures")
                            })
                            Button(action: {
                                selectedFilter = "Electronics and Machines"
                            }, label: {
                                Text("Electronics and Machines")
                            })
                            Button(action: {
                                selectedFilter = "Foods and Drinks"
                            }, label: {
                                Text("Foods and Drinks")
                            })
                            Button(action: {
                                selectedFilter = "Clothes and Accesories"
                            }, label: {
                                Text("Clothes and Accesories")
                            })
                            Button(action: {
                                selectedFilter = ""
                            }, label: {
                                Text("All Items")
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
