//
//  PostProtocol.swift
//  VKNews
//
//  Created by Петр on 07/12/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation

protocol PostProtocol: Codable {
    
    /// Type of post
    var type: String { get set }
    
    /// Post id
    var postId: Int { get set }
    
    /// Source id
    var sourceId: Int { get set }
    
    /// Date of post
    var date: Int { get set }
    
    /// Text
    var text: String { get set }
    
    /// Array of attachments
    var attachments: [Attachment]? { get set }
    
    /// Comments info
    var comments: Comments? { get set }
    
    /// Likes info
    var likes: Likes? { get set }
    
    /// Reposts info
    var reposts: Reposts? { get set }
    
    /// 1 - Marked as ads, 0 - not marked
    var markedAsAds: Int? { get set }
}
