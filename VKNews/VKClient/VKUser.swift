//
//  VKUser.swift
//  VKNews
//
//  Created by Петр on 06/12/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation

struct VKUserResponse: UserResponseProtocol {
    var response: [VKUser]
}


struct VKUser : Codable, UserProtocol {
    
    var screenName: String
    var firstName: String
    var lastName: String
    var birthday: String
    var status: String
    var mobilePhone: String
    var homeTown: String
    var photo: URL
    
    enum CodingKeys: String, CodingKey {
        case screenName = "screen_name"
        case firstName = "first_name"
        case lastName = "last_name"
        case birthday = "bdate"
        case status
        case mobilePhone = "mobile_phone"
        case homeTown = "home_town"
        case photo = "photo_100"
    }
}

struct UserPostResponse: Codable {
    var response: PostIdResponse
}

struct PostIdResponse: Codable {
    
    var postId: Int
    
    enum CodingKeys: String, CodingKey {
        case postId = "post_id"
    }
}

