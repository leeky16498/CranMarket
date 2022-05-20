//
//  MyListingView.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 19/05/2022.
//

import SwiftUI
import Kingfisher

struct MyListingView: View {
    
    let item : ItemModel
    @StateObject var vm = FeedViewModel()
    @State private var showEditView : Bool = false
    
    var body: some View {
        VStack {
            HStack {
                KFImage(URL(string: item.imageURL.first ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width : 110, height : 110)
                    .cornerRadius(4)
                    .padding(.horizontal, 4)
                
                VStack(alignment : .leading, spacing: 2) {
                    Text(item.title)
                        .font(.body)
                        .foregroundColor(.black)
                        .lineLimit(1)
                    
                    Text(item.contactInfo)
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    Text("£\(item.price)")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.vertical, 12)
                    
                    HStack {
                        Button(action: {
                            vm.deleteItems(item: item)
                        }, label: {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        })
                        .padding(.trailing, 2)
                    
                        Button(action: {
                            showEditView.toggle()
                        }, label: {
                            Image(systemName: "pencil")
                                .foregroundColor(.blue)
                        })
                        .sheet(isPresented: $showEditView) {
                            UploadView(item: item)
                        }
                        
                        Spacer()
                    }
                }
                Spacer()
            }//hst
            .padding(4)
            
            Divider()
        }//vst
        .padding(.horizontal)
    }
}
