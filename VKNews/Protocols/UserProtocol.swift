//
//  UserProtocol.swift
//  VKNews
//
//  Created by Петр on 07/12/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation

protocol UserProtocol {
    
    /// Alias
    var screenName: String { get set }
    
    /// First name
    var firstName: String { get set }
    
    /// Last name
    var lastName: String { get set }
    
    /// birthday
    var birthday: String { get set }
    
    /// Page status
    var status: String { get set }
    
    /// Mobile phonr
    var mobilePhone: String { get set }
    
    /// Home town
    var homeTown: String { get set }
    
    /// Photo link
    var photo: URL { get set }
    
}
