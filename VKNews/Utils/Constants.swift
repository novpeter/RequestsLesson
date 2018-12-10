//
//  Constants.swift
//  VKNews
//
//  Created by Петр on 01/12/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Seques and identifiers

enum Seques: String {
    case LoginSegue
    case NewsFeed
    case AuthSuccess
}

let postIdentifier = "post"

// MARK: - numeric constants

let splashScreenDelay: Int = 2000
let cellSpacingHeight: CGFloat = 5
let estimatedRowHeight = 220

// MARK: - string constants

enum PageTitles: String {
    case Loading = "Loading..."
    case Settings = "Settings"
    case User = "User information"
    case Feed = "Feed"
    case Publishing = "Publishing..."
}

let accessTokenParameter = "access_token"
let userIdParameter = "user_id"

let postType = "photo"

// MARK: - Links

enum VKLinks: String {
    
    case token = "https://oauth.vk.com/authorize?client_id=5490057&display=mobile&redirect_uri=https://oauth.vk.com/blank.html&scope=wall,friends,offline,groups&response_type=token&v=5.52"
    
    case getUserInfoMethod = "users.get"
    case getUserInfoOptions = "&fields=photo_100,screen_name,bdate,status,home_town,contacts&v=5.52"
    
    case getNewsfeedMethod = "newsfeed.get"
    case getNewsfeedOptions = "&fields=name,photo_100&filters=post&count=50&return_banned=0&v=5.52"
    
    case publishNewPostMethod = "wall.post"
    
    case versionOption = "&v=5.52"
    
    case likePostMethod = "likes.add"
    case dislikePostMethod = "likes.delete"
}

enum ResponseCodingKeys: String {
    case response
    case items
}

// MARK: - Others

enum PostSource: String {
    case VK = "vk"
}

// MARK: - Errors

let unwrapperError = NSError(
    domain: NSURLErrorDomain,
    code: 1,
    userInfo: [NSLocalizedDescriptionKey: "Can't unwrap data"]
)

let wrongUrlError = NSError(
    domain: NSURLErrorDomain,
    code: 2,
    userInfo: [NSLocalizedDescriptionKey: "Wrong URL"]
)

let decodeError = NSError(
    domain: NSURLErrorDomain,
    code: 3,
    userInfo: [NSLocalizedDescriptionKey: "Can't decode data"]
)

// MARK: - Functions

func abs(number: Int) -> Int {
    if number < 0 {
        return -1 * number
    }
    return number
}

func format(duration: TimeInterval) -> String {
    
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.day, .hour, .minute, .second]
    formatter.unitsStyle = .abbreviated
    formatter.maximumUnitCount = 1
    
    return formatter.string(from: NSDate().timeIntervalSince1970 - duration)!
}
