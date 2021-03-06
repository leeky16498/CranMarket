//
//  PostView.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 03/05/2022.
//

import SwiftUI
import Kingfisher

struct PostView: View {
    
    let item : ItemModel
    @State private var showSaveItemAlert : Bool = false
    @StateObject var vm = FeedViewModel()
    
    var body: some View {
        VStack {
            HStack {
                KFImage(URL(string: item.imageURL.first ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width : 100, height : 100)
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
        .padding(.horizontal)
        .onTapGesture {}
        .onLongPressGesture {
            showSaveItemAlert.toggle()
        }
        .actionSheet(isPresented: $showSaveItemAlert) {
            ActionSheet(title: Text("Do you wanna save this item?"), message: Text("If you tap, the item will be saved in your drawer!"), buttons: [
                .default(Text("Save the item"), action: {
                    vm.storeSavedItemInformation(title: item.title, description: item.description, category: item.category, contactInfo: item.contactInfo, price: item.price, imageUrls: item.imageURL, seller: item.seller) { result in
                        if result {
                            vm.fetchSavedItems()
                        }
                    }
                }),
                .cancel()
            ])
        }
    }
}

//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView()
//    }
//}
