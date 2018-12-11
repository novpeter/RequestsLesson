//
//  GroupProtocol.swift
//  VKNews
//
//  Created by Петр on 10/12/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation

protocol GroupProtocol: Codable {
    
    /// Group id
    var id: Int { get set }
    
    /// Group name
    var name: String { get set }
    
    /// Group photo link
    var photo: URL? { get set }
}
