//
//  PostModel.swift
//  SwiftRequests
//
//  Created by Ильдар Залялов on 26/11/2018.
//  Copyright © 2018 Ильдар Залялов. All rights reserved.
//

import Foundation

struct PostModel: Codable {
    
    var userId: Int
    var id: Int
    var title: String
    var body: String

    
}
