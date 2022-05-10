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
                ImageView(item: item)
                
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
