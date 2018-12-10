//
//  RequestManager.swift
//  VKNews
//
//  Created by Петр on 30/11/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation
import UIKit

class RequestManager: RequestManagerProtocol {
    
    static let sharedInstance = RequestManager()
    
    private init() {}
    
    func fetchRequest<T>(with url: URLRequest, decodeType: T.Type, completionBlock: @escaping (Response<T>) -> ()) where T: Codable {
        
        var request = url
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            var result: Response<T>

            defer {
                DispatchQueue.main.async {
                    completionBlock(result)
                }
            }
            
            if error != nil {
                print("Error: \(String(describing: error?.localizedDescription))")
                result = .failure(error: error!)
            }
            
            guard let unwrappedData = data else {
                
                result = .failure(error: unwrapperError as Error)
                return
            }
            
            let decoder = JSONDecoder()
            
            if let models = try? decoder.decode(T.self, from: unwrappedData) {
                result = .success(data: models)
            }
            else {
                result = .failure(error: decodeError as Error)
            }
            
        }
        
        task.resume()

    }
    
    func loadImage(with url: URL?, completionBlock: @escaping (Response<Data>) -> Void) {
        
        guard url != nil else {
            
            completionBlock(Response<Data>.failure(error: wrongUrlError as Error))
            return
        }

        getData(from: url!) { data, response, error in
            
            var result: Response<Data>
            
            defer {
                DispatchQueue.main.async {
                    completionBlock(result)
                }
            }
            
            if error != nil {
                print("Error: \(String(describing: error?.localizedDescription))")
                result = .failure(error: error!)
            }
            
            if let unwrappedData = data {
                result = .success(data: unwrappedData)
            }
            else {
    
                result = .failure(error: unwrapperError as Error)
                return
            }

        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
