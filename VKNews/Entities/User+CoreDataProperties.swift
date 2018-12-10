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

    @NSManaged public var birthday: String?
    @NSManaged public var firstName: String?
    @NSManaged public var homeTown: String?
    @NSManaged public var lastName: String?
    @NSManaged public var phone: String?
    @NSManaged public var screenName: String?
    @NSManaged public var status: String?
    @NSManaged public var id: UUID?
    @NSManaged public var photo: URL?

}
