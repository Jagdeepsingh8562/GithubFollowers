//
//  User.swift
//  GithubFollowers
//
//  Created by Jagdeep Singh on 16/05/21.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let user = try? newJSONDecoder().decode(User.self, from: jsonData)

import Foundation

// MARK: - User
struct User: Codable {
    let login: String
    let avatarURL: String
    let htmlURL: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos, publicGists, followers, following: Int
    let followingURL: String
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        case bio, location, name
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
        case followingURL = "following_url"
        case createdAt = "created_at"
        
    }
}

