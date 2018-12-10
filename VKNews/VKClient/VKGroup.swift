//
//  VKGroup.swift
//  VKNews
//
//  Created by Петр on 08/12/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation

struct VKGroup: GroupProtocol {
    
    var id: Int
    var name: String
    var photo: URL?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo = "photo_100"
    }
}
