//
//  Post+CoreDataProperties.swift
//  VKNews
//
//  Created by Петр on 10/12/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    /// Count of comments
    @NSManaged public var commentsCount: Int64
    
    /// Date of publishing
    @NSManaged public var date: Int32
    
    /// Identificator
    @NSManaged public var id: UUID?
    
    /// Count of likes
    @NSManaged public var likesCount: Int64
    
    /// Post identificator
    @NSManaged public var postId: Int64
    
    /// Count of reposts
    @NSManaged public var repostsCount: Int64
    
    /// Source identificator
    @NSManaged public var sourceId: Int64
    
    /// Post text
    @NSManaged public var text: String?
    
    /// 1 - user liked, 0 - didn't like
    @NSManaged public var userLikes: Int16
    
    /// Source name
    @NSManaged public var sourceName: String?
    
    /// Source avatar link
    @NSManaged public var sourceAvatar: URL?
    
    /// Attached post image
    @NSManaged public var attachedImage: URL?

}
