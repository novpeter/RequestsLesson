//
//  DataManager.swift
//  VKNews
//
//  Created by Петр on 30/11/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation
import CoreData

class DataManager: DataManagerProtocol {
    
    static let sharedInstance = DataManager()
    
    private let defaults = UserDefaults.standard
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: - Core Data stack
    
    private lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "VKNews")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentContainer.persistentStoreCoordinator
        
        return managedObjectContext
    }()
    
    func saveContext () {
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Operation queues
    
    private lazy var getOperationQueue: OperationQueue = {
        
        let queue = OperationQueue()
        queue.qualityOfService = .userInteractive
        queue.name = "Get operation queue"
        
        return queue
    }()
    
    private lazy var saveOperationQueue: OperationQueue = {
        
        let queue = OperationQueue()
        queue.name = "Save operation queue"
        
        return queue
    }()
    
    private lazy var deleteOperationQueue: OperationQueue = {
        
        let queue = OperationQueue()
        queue.name = "Delete operation queue"
        
        return queue
    }()
    
    // MARK: - Constructor
    
    private init() { }
    
    // MARK: - Operations with client
    
    func getClient<T>(with type: T.Type) -> T? where T : Codable {
        
        if let encodedData = defaults.object(forKey: String(describing: T.self)) {
            
            let client = try! decoder.decode(T.self, from: encodedData as! Data) as T
            return client
        }
        
        return nil
    }  
    
    func asyncGetClient<T>(with type: T.Type, completionBlock: @escaping (T?) -> Void) where T : Codable {
        
        getOperationQueue.addOperation {
            completionBlock(self.getClient(with: T.self))
        }
    }
    
    func saveClient<T>(client: T) where T : Codable {
        
        let encodedData = try? encoder.encode(client)
        defaults.set(encodedData, forKey: String(describing: T.self))
    }
    
    func asyncSaveClient<T>(client: T, completionBlock: @escaping (Bool) -> Void) where T : Codable {
        
        saveOperationQueue.addOperation {
            
            self.saveClient(client: client)
            completionBlock(true)
        }
    }
    
    func deleteClient<T>(client: T) where T : Codable {
        defaults.removeObject(forKey: String(describing: T.self))
    }
    
    func asyncDeleteClient<T>(client: T, completionBlock: @escaping (Bool) -> Void) where T : Codable {
        
        deleteOperationQueue.addOperation {
        
            self.deleteClient(client: client)
            completionBlock(true)
        }
    }
    
    // MARK: - Operations with models
    
    func getAll<T>(with type: T.Type) -> [T]? where T : NSManagedObject {
        
        let models = try? context.fetch((T.self).fetchRequest()) as! [T]
        
        return models
    }
    
    func asyncGetAll<T>(with type: T.Type, completionBlock: @escaping ([T]?) -> Void) where T : NSManagedObject {
        
        DispatchQueue.main.async {
            completionBlock(self.getAll(with: type))
        }
    }
    
    func delete<T>(model: T) where T : NSManagedObject {
        
        context.delete(model)
        self.saveContext()
    }
    
    func asyncDelete<T>(model: T, completionBlock: @escaping (Bool) -> Void) where T : NSManagedObject {
        
        DispatchQueue.main.async {
            self.delete(model: model)
        }
    }
    
}
