//
//  Follower.swift
//  GithubFollowers
//
//  Created by Jagdeep Singh on 16/05/21.
//

import Foundation

struct Follower: Codable {
    var login: String
    var avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}
