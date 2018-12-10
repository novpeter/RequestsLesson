//
//  RequestManagerProtocol.swift
//  VKNews
//
//  Created by Петр on 30/11/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation

/// Feature to return response
///
/// - success: data
/// - failure: exception
enum Response<T> where T:Codable  {
    case success(data: T)
    case failure(error: Error)
}

protocol RequestManagerProtocol {
    
    /// Obtains request and return result
    ///
    /// - Parameters:
    ///   - url: request url
    ///   - decodeType: type for decoding
    ///   - completionBlock: to return result
    func fetchRequest<T: Codable>(with url: URLRequest, decodeType: T.Type, completionBlock: @escaping (Response<T>) -> ()) -> Void
    
    /// Loads image by given url
    ///
    /// - Parameters:
    ///   - url: given url
    ///   - completionBlock: to return image data or exception
    func loadImage(with url: URL?, completionBlock: @escaping (Response<Data>) -> Void) -> Void
}
