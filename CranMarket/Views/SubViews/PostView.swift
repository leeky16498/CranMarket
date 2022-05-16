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
    @StateObject var vm = FeedViewModel()
    @State private var isSaved : Bool = false
    
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
                    
                    HStack {
                        Image(systemName: isSaved ? "heart.fill" : "heart")
                            .foregroundColor(isSaved ? .red : .black)
                            .onTapGesture {
                                self.isSaved.toggle()
                            }
                            .padding(.horizontal)
                            
                        Button(action: {
                            vm.deleteItems(item: item) { result in
                                vm.fetchItems()
                            }
                        }, label: {
                            Image(systemName: "trash")
                                .foregroundColor(.blue)
                        })
                        
                        Spacer()
                    }
                }
                Spacer()
            }//hst
            .padding(4)
            
            Divider()
        }//vst
    }
}

//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView()
//    }
//}
