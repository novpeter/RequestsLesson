//
//  User+CoreDataClass.swift
//  VKNews
//
//  Created by Петр on 07/12/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {

    convenience init(context: NSManagedObjectContext, user: UserProtocol) {
        self.init(context: context)
        
        self.id = UUID()
        self.screenName = user.screenName
        self.photo = user.photo
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.birthday = user.birthday
        self.homeTown = user.homeTown
        self.phone = user.mobilePhone
        self.status = user.status
    }
}
