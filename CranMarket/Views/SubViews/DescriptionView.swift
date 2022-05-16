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
                            .scaledToFill()
                    }
                }
                .frame(maxWidth : .infinity)
                .frame(height : 300)

                .tabViewStyle(.page)
                
                HStack {
                    Text(item.title)
                        .font(.title.bold())
                    Spacer()
                }
                .padding()
                
                HStack {
                    Text("ContactInfo : " + item.contactInfo)
                        .font(.body)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 4)
                
                HStack {
                    Text("Category : " + item.category)
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Text(item.description)
                        .font(.body)
                    Spacer()
                }
                .padding()
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
