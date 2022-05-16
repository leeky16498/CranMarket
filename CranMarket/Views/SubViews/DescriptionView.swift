//
//  DescriptionView.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 16/05/2022.
//

import SwiftUI
import Kingfisher

struct DescriptionView: View {
    
    let item : ItemModel
    
    var body: some View {
        ScrollView {
            VStack {
                TabView {
                    ForEach(item.imageURL, id : \.self) {
                        KFImage(URL(string: $0))
                            .resizable()
                    }
                }
                .frame(maxWidth : .infinity)
                .frame(height : 300)
                .scaledToFill()
                .tabViewStyle(.page)
                
                HStack {
                    Text(item.title)
                        .font(.title.bold())
                    Spacer()
                }
                .padding()
                
                HStack {
                    Text(item.category)
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Spacer()
                }
                
                VStack(alignment : .leading) {
                    Text(item.description)
                        .font(.body)
                }
                .frame(maxWidth : .infinity)
            }
        }
        .navigationTitle("Item details")
    }
}

//struct DescriptionView_Previews: PreviewProvider {
//    static var previews: some View {
//        DescriptionView()
//    }
//}
