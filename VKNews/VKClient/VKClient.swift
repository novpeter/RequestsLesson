//
//  VKClient.swift
//  VKNews
//
//  Created by Петр on 03/12/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation

class VKClient: Codable {
    
    var accessToken: String
    var userId: String
    
    init(accessToken: String, userId: String) {
        self.accessToken = accessToken
        self.userId = userId
    }
    
}
