//
//  UserModel.swift
//  CranMarket
//
//  Created by Kyungyun Lee on 05/05/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct UserModel : Identifiable, Codable {
    @DocumentID var id : String?
    let email, username, profileImageUrl : String
}
