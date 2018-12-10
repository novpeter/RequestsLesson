//
//  VKManager.swift
//  VKNews
//
//  Created by Петр on 03/12/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation

class VKManager {
    
    static let sharedInstance = VKManager()
    
    private let dataManager = DataManager.sharedInstance
    private let requestManager = RequestManager.sharedInstance
    
    private let api = "https://api.vk.com/method/"
    
    private init() { }
    
    func createAndSaveClient(credentials: [String:String]) {

        if let token = credentials[accessTokenParameter], let user = credentials[userIdParameter] {
            
            let client = VKClient(accessToken: token, userId: user)
            dataManager.saveClient(client: client)
        }
    }
    
    func updateUserInfo(completionBlock: @escaping (Response<VKUserResponse>) -> ()) {
        
        guard let client = dataManager.getClient(with: VKClient.self) else { return }
        
        self.deleteOldUser()
        
        let accessToken = "?access_token=\(client.accessToken)"
        let urlString = api + VKLinks.getUserInfoMethod.rawValue + accessToken + VKLinks.getUserInfoOptions.rawValue
        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!)

        requestManager.fetchRequest(with: urlRequest, decodeType: VKUserResponse.self, completionBlock: completionBlock)
    }
    
    private func deleteOldUser() {
        
        if let users = dataManager.getAll(with: User.self) {
            
            for user in users {
                dataManager.asyncDelete(model: user) { (result) in
                    if !result {
                        print("Error during deleting")
                    }
                }
            }
        }
    }
    
    func updatePosts(completionBlock: @escaping ([Post]) -> ()) {
        
        guard let client = dataManager.getClient(with: VKClient.self) else { return }
     
        self.deleteOldPosts()
        
        let accessToken = "?access_token=\(client.accessToken)"
        let urlString = api + VKLinks.getNewsfeedMethod.rawValue + accessToken + VKLinks.getNewsfeedOptions.rawValue
        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!)
        let group = DispatchGroup()
        
        group.enter()
        
        requestManager.fetchRequest(with: urlRequest, decodeType: VKPostResponse.self) { [weak self] (response) in
            
            guard let self = self else { return }
            
            var resultPosts: [Post] = []
            
            switch response {
            case .success(let data):
                
                if let posts = data.response?.items, let groups = data.response?.groups {
                    
                    for post in posts {
                        
                        let group = groups.filter { $0.id == abs(post.sourceId) }.first
                        resultPosts.append(Post(context: self.dataManager.context, post: post, group: group))
                    }
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
            
            group.leave()
            
            group.notify(queue: .main, execute: {
                
                self.dataManager.saveContext()
                completionBlock(resultPosts)
            })
        }
        
        
    }
    
    private func deleteOldPosts() {
        
        if let posts = dataManager.getAll(with: Post.self) {
            
            for post in posts {
                dataManager.asyncDelete(model: post) { (result) in
                    if !result {
                        print("Error during deleting")
                    }
                }
            }
        }
    }

    func publishNewPost(with message: String, completionBlock: @escaping (Bool) -> ()) {
        
        guard let client = dataManager.getClient(with: VKClient.self) else { return }
        
        let accessToken = "?access_token=\(client.accessToken)"
        let urlString = api + VKLinks.publishNewPostMethod.rawValue + accessToken + "&message=\(message)" + VKLinks.versionOption.rawValue
        let url = URL(string: urlString.replacingOccurrences(of: " ", with: "%20"))
        let urlRequest = URLRequest(url: url!)
        
        requestManager.fetchRequest(with: urlRequest, decodeType: UserPostResponse.self) { (response) in

            switch response {
            case .success(let data):
                print("New post id: \(data.response.postId)")
                completionBlock(true)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completionBlock(false)
            }
        }
    }
    
    func likePost(with post: Post, completionBlock: @escaping (Int?) -> ()) {
        
        guard let client = dataManager.getClient(with: VKClient.self) else { return }
        
        let accessToken = "?access_token=\(client.accessToken)"
        let type = "&type=post"
        let ownerId = "&owner_id=\(post.sourceId)"
        let itemId = "&item_id=\(post.postId)"
        
        let urlString = api + VKLinks.likePostMethod.rawValue + accessToken + type + ownerId + itemId + VKLinks.versionOption.rawValue
        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!)
        
        requestManager.fetchRequest(with: urlRequest, decodeType: LikePostResponse.self) { (response) in
            
            switch response {
            case .success(let data):
                completionBlock(data.response.likes)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completionBlock(nil)
            }
        }
    }
    
    func dislikePost(with post: Post, completionBlock: @escaping (Int?) -> ()) {
        
        guard let client = dataManager.getClient(with: VKClient.self) else { return }
        
        let accessToken = "?access_token=\(client.accessToken)"
        let type = "&type=post"
        let ownerId = "&owner_id=\(post.sourceId)"
        let itemId = "&item_id=\(post.postId)"
        
        let urlString = api + VKLinks.dislikePostMethod.rawValue + accessToken + type + ownerId + itemId + VKLinks.versionOption.rawValue
        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!)
        
        requestManager.fetchRequest(with: urlRequest, decodeType: LikePostResponse.self) { (response) in
            
            switch response {
            case .success(let data):
                print("Likes count : \(data.response.likes)")
                completionBlock(data.response.likes)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completionBlock(nil)
            }
        }
    }
}
