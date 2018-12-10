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

    @NSManaged public var commentsCount: Int64
    @NSManaged public var date: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var likesCount: Int64
    @NSManaged public var postId: Int64
    @NSManaged public var repostsCount: Int64
    @NSManaged public var sourceId: Int64
    @NSManaged public var text: String?
    @NSManaged public var userLikes: Int16
    @NSManaged public var sourceName: String?
    @NSManaged public var sourceAvatar: URL?
    @NSManaged public var attachedImage: URL?

}
