//
//  PostProtocol.swift
//  VKNews
//
//  Created by Петр on 07/12/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation

protocol PostProtocol: Codable {
    
    var type: String { get set }
    var postId: Int { get set }
    var sourceId: Int { get set }
    var date: Int { get set }
    var text: String { get set }
    var attachments: [Attachment]? { get set }
    var comments: Comments? { get set }
    var likes: Likes? { get set }
    var reposts: Reposts? { get set }
    var markedAsAds: Int? { get set }
}
