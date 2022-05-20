//
//  SavedPostView.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 19/05/2022.
//
import SwiftUI
import Kingfisher

struct SavedPostView: View {
    
    let item : ItemModel
    @EnvironmentObject var vm : FeedViewModel
    @State private var showDeleteSavedItem : Bool = false
    
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
                        .padding(.vertical)
                }
                Spacer()
            }//hst
            .padding(4)
            
            Divider()
        }//vst
        .onTapGesture {}
        .onLongPressGesture {
            showDeleteSavedItem.toggle()
        }
        .actionSheet(isPresented: $showDeleteSavedItem) {
            ActionSheet(title: Text("Do you wanna delete item in the list?"), message: Text("If you tap, the item will be deleted from your drawer"), buttons: [
                .destructive(Text("Delete"), action: {
                    vm.deleteSavedItem(item: item)
                }),
                .cancel()
            ])
        }
    }
}
