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
    
    var body: some View {
        VStack {
            HStack {
                KFImage(URL(string: item.imageURL))
                    .resizable()
                    .scaledToFill()
                    .frame(width : 110, height : 110)
                    .cornerRadius(8)
                
                VStack(alignment : .leading) {
                    Text(item.title)
                        .font(.headline)
                        .lineLimit(1)
                    
                    Text(item.contactInfo)
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    Text("$\(item.price)")
                        .font(.title.bold())
                        .padding(.vertical)
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            Divider()
        }
    }
}

//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView()
//    }
//}
