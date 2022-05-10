//
//  ImageView.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 10/05/2022.
//

import SwiftUI

struct ImageView: View {
    
    @StateObject var vm : ImageViewModel
    
    init(item : ItemModel) {
        _vm = StateObject(wrappedValue: ImageViewModel(item: item))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()

            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(.gray)
            }
        }
        .frame(width : 120, height : 120)
        .cornerRadius(8)
    }
}

//struct ImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageView()
//    }
//}
