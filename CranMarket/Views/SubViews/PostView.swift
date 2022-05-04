//
//  PostView.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 03/05/2022.
//

import SwiftUI

struct PostView: View {
    
    var body: some View {
        VStack {
            HStack {
                Image("dog1")
                    .resizable()
                    .frame(width : 130, height : 130)
                    .scaledToFill()
                    .cornerRadius(8)
                    .padding(.trailing, 10)
                    .shadow(radius: 5)
                
                VStack(alignment : .leading) {
                    Text("Cutie dog")
                        .font(.headline)
                        .lineLimit(1)
                    
                    Text("Seller : Kyungyun Lee")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    Text("$220")
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

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
