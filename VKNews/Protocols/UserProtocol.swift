//
//  UserProtocol.swift
//  VKNews
//
//  Created by Петр on 07/12/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation

protocol UserProtocol {
    
    var screenName: String { get set }
    var firstName: String { get set }
    var lastName: String { get set }
    var birthday: String { get set }
    var status: String { get set }
    var mobilePhone: String { get set }
    var homeTown: String { get set }
    var photo: URL { get set }
    
}
