//
//  DataManagerProtocol.swift
//  VKNews
//
//  Created by Петр on 30/11/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation
import CoreData

// Protocol for working with data
protocol DataManagerProtocol {
    
    // CoreData context
    var context: NSManagedObjectContext { get set }
    
    /// Save context
    ///
    func saveContext() -> Void
    
    /// Returns client data from UserDefaults
    ///
    /// - Parameter type: type of client
    /// - Returns: client
    func getClient<T: Codable>(with type: T.Type) -> T?
    
    /// Asynchronously returns client data from UserDefaults
    ///
    /// - Parameters:
    ///   - type: type of client
    ///   - completionBlock: to return the client
    func asyncGetClient<T: Codable>(with type: T.Type, completionBlock: @escaping (T?) -> Void)
    
    /// Saves new client in UserDefaults
    ///
    /// - Parameter client: client
    func saveClient<T: Codable>(client: T) -> Void
    
    /// Asynchronously saves new client in UserDefaults
    ///
    /// - Parameters:
    ///   - client: client
    ///   - completionBlock: to return the result of operation
    func asyncSaveClient<T: Codable>(client: T, completionBlock: @escaping (Bool) -> Void)
    
    /// Deletes new client in UserDefaults
    ///
    /// - Parameter client: client
    func deleteClient<T: Codable>(client: T) -> Void
    
    /// Asynchronously saves new client in UserDefaults
    ///
    /// - Parameters:
    ///   - client: client
    ///   - completionBlock: to return the result of operation
    func asyncDeleteClient<T: Codable>(client: T, completionBlock: @escaping (Bool) -> Void)
    
    
    
    /// Returns all entities of given type
    ///
    /// - Parameter type: type of models
    /// - Returns: the set of models
    func getAll<T: NSManagedObject>(with type: T.Type) -> [T]?
    
    /// Asynchronously returns all entities of given type
    ///
    /// - Parameter
    ///   - type: type of models
    ///   - completionBlock: block for returning models
    /// - Returns: the set of models
    func asyncGetAll<T: NSManagedObject>(with type: T.Type, completionBlock: @escaping ([T]?) -> Void)

    /// Adds new model in database
    ///
    /// - Parameter model: model
    func delete<T: NSManagedObject>(model: T) -> Void
    
    /// Asynchronously adds new model in database
    ///
    /// - Parameters:
    ///   - model: model to delete
    ///   - completionBlock: for returing result of operations
    func asyncDelete<T: NSManagedObject>(model: T, completionBlock: @escaping (Bool) -> Void)

}
