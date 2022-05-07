//
//  PostView.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 03/05/2022.
//

import SwiftUI

struct PostView: View {
    
    let item : ItemModel
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: item.imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width : 130, height : 130)
                        .cornerRadius(8)
                        .padding(.trailing, 10)
                        .shadow(radius: 5)
                }placeholder: {
                    ProgressView()
                        .frame(width : 130, height : 130)
                        .cornerRadius(8)
                        .padding(.trailing, 10)
                        .shadow(radius: 5)
                }
                
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
