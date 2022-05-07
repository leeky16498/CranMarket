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
    @StateObject var vm = FeedViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView {
                LazyVStack {
                    ForEach(vm.feeds) { item in
                        PostView(item: item)
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Items 🎁")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Menu(content: {
                            Button(action: {
                                print("Room")
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
        }
        .onAppear {
            vm.fetchItems()
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
