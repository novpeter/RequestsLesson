//
//  VKPost.swift
//  VKNews
//
//  Created by Петр on 05/12/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation

struct VKPostResponse: PostResponseProtocol {
    var response: Items?
}

struct Items: Codable {
    var items: [VKPost]?
    var groups: [VKGroup]?
}

struct VKPost: PostProtocol {
    
    var type: String
    var postId: Int
    var sourceId: Int
    var date: Int
    var text: String
    var attachments: [Attachment]?
    var comments: Comments?
    var likes: Likes?
    var reposts: Reposts?
    
    enum CodingKeys: String, CodingKey {
        case type
        case postId = "post_id"
        case sourceId = "source_id"
        case date
        case text
        case attachments
        case comments
        case likes
        case reposts
    }
}

struct Attachment: Codable {
    var type: String
    var photo: Photo?
}

struct Photo: Codable {
    var id: Int
    var link: URL?
    
    enum CodingKeys: String, CodingKey {
        case id
        case link = "photo_604"
    }
}

struct Comments: Codable {
    var count: Int
}

struct Likes: Codable {
    var count: Int
    var userLikes: Int
    var canLike: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
    }
}

struct Reposts: Codable {
    var count: Int
    var userReposted: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

//class VKPostResult: PostProtocol {
//    
//    var postId: Int
//    var sourceId: Int
//    var date: Int
//    var text: String
//    var sourceLabel: String
//    var sourceAvatar: Data
//    var attachedImage: Data?
//    var commentsCount: Int
//    var likesCount: Int
//    var userLikes: Int
//    var repostsCount: Int
//    
//    init(postId: Int, sourceId: Int, date: Int, text: String, sourceLabel: String, sourceAvatar: Data, attachedImage: Data?, commentsCount: Int, likesCount: Int, userLikes: Int, repostsCount: Int) {
//        
//        self.postId = postId
//        self.sourceId = sourceId
//        self.date = date
//        self.text = text
//        self.sourceLabel = sourceLabel
//        self.sourceAvatar = sourceAvatar
//        self.attachedImage = attachedImage
//        self.commentsCount = commentsCount
//        self.userLikes = userLikes
//        self.likesCount = likesCount
//        self.repostsCount = repostsCount
//    }
//}
