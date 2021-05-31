//
//  GFRepoItemVC.swift
//  GithubFollowers
//
//  Created by Jagdeep Singh on 31/05/21.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
    }
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, count: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, count: user.publicGists)
        actionButton.set(bgColor: .systemPurple, title: "Github Profile")
    }
}
