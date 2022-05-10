//
//  UserModel.swift
//  CaseDeneme
//
//  Created by Ahmet WOW on 28/04/2022.
//

import Foundation

struct Users: Codable {
    let userFullName: String
    var userImageURL: String
    let createdAt: String
    let likeCount, commentCount: Int
    var postImage: String
    let postMessage: String

    enum CodingKeys: String, CodingKey {
        case userFullName
        case userImageURL = "userImageUrl"
        case createdAt, likeCount, commentCount, postImage, postMessage
    }
}
