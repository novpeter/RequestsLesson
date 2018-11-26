//
//  ApiManager.swift
//  SwiftRequests
//
//  Created by Ильдар Залялов on 26/11/2018.
//  Copyright © 2018 Ильдар Залялов. All rights reserved.
//

import Foundation
import UIKit

enum PostsResponse {
    case success(models: [PostModel])
    case failure(error: Error)
}

class ApiManager {
    
    fileprivate let baseUrl = "https://jsonplaceholder.typicode.com"
    fileprivate let postsEndPoint = "/posts"
    
    func obtainPosts(completionBlock: @escaping (PostsResponse) -> ()) {
        
        let fullUrl = baseUrl + postsEndPoint
        
        guard let url = URL(string: fullUrl) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            var result: PostsResponse
            
            defer {
                DispatchQueue.main.async {
                    completionBlock(result)
                }
            }
            
            if error != nil {
                print("Error: \(error?.localizedDescription)")
                result = .failure(error: error!)
            }
            
            guard let unwrappedData = data else {
                
                let unwrapperError = NSError(domain: NSURLErrorDomain, code: 777, userInfo: [NSLocalizedDescriptionKey: "Can't unwrap data"])
                result = .failure(error: unwrapperError as Error)
                
                return
            }
            let decoder = JSONDecoder()
            
            if let models = try? decoder.decode([PostModel].self, from: unwrappedData) {
                
                result = .success(models: models)
            }
            else {
                
                let decodeError = NSError(domain: NSURLErrorDomain, code: 777, userInfo: [NSLocalizedDescriptionKey: "Can't decode data"])
                result = .failure(error: decodeError as Error)
            }
            
        }
        
        task.resume()
    }
}
