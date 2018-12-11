//
//  Post+CoreDataClass.swift
//  VKNews
//
//  Created by Петр on 10/12/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Post)
public class Post: NSManagedObject {
    
    convenience init(context: NSManagedObjectContext, post: PostProtocol, group: GroupProtocol?) {
        self.init(context: context)
        
        self.id = UUID()
        self.commentsCount = Int64(post.comments?.count ?? 0)
        self.date = Int32(post.date)
        self.likesCount = Int64(post.likes?.count ?? 0)
        self.postId = Int64(post.postId)
        self.repostsCount = Int64(post.reposts?.count ?? 0)
        self.sourceId = Int64(post.sourceId)
        self.text = post.text
        self.userLikes = Int16(post.likes?.userLikes ?? 0)
        self.sourceName = group?.name
        self.sourceAvatar = group?.photo
        self.attachedImage = post.attachments?.filter({ (attachment) -> Bool in
            attachment.type == postType
        }).first?.photo?.link ?? nil
        self.markedAsAds = Int16(post.markedAsAds ?? 0)
    }
    
}
