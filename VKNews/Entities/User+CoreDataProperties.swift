//
//  User+CoreDataProperties.swift
//  VKNews
//
//  Created by Петр on 07/12/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    
    /// Birthday date
    @NSManaged public var birthday: String?
    
    /// User's first name
    @NSManaged public var firstName: String?
    
    /// User's home town
    @NSManaged public var homeTown: String?
    
    /// User's last name
    @NSManaged public var lastName: String?
    
    /// User's phone
    @NSManaged public var phone: String?
    
    /// User's alias (screenname)
    @NSManaged public var screenName: String?
    
    /// User's status
    @NSManaged public var status: String?
    
    /// Unique identificator
    @NSManaged public var id: UUID?
    
    /// User's avatar link
    @NSManaged public var photo: URL?

}
