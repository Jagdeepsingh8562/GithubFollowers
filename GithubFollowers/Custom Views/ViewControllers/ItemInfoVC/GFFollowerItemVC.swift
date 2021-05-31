//
//  GFFollowerItemVC.swift
//  GithubFollowers
//
//  Created by Jagdeep Singh on 31/05/21.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
    }
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, count: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, count: user.following)
        actionButton.set(bgColor: .systemGreen, title: "Get Follower")
    }
}
