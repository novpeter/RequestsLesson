//
//  ClientManagerProtocol.swift
//  VKNews
//
//  Created by Петр on 05/12/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation
import CoreData

protocol ClientManagerProtocol {
    
    /// Create the user from given credentials and
    /// save in UserDefaults
    ///
    /// - Parameter credentials: given data
    func createAndSaveClient(credentials: [String:String]) -> Void

    /// Updates user info
    ///
    /// - Parameter completionBlock: to return user info
    func updateUserInfo<T: NSManagedObject>(completionBlock: @escaping (Response<T>) -> ()) -> Void
    
    /// Updates posts
    ///
    /// - Parameter completionBlock: to return new posts
    func updatePosts<T: NSManagedObject>(completionBlock: @escaping ([T]) -> ()) -> Void

}
