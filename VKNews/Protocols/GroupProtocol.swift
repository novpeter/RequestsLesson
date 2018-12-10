//
//  GroupProtocol.swift
//  VKNews
//
//  Created by Петр on 10/12/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation

protocol GroupProtocol: Codable {
    
    var id: Int { get set }
    var name: String { get set }
    var photo: URL? { get set }
}
