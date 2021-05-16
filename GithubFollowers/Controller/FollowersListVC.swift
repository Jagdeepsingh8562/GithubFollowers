//
//  FollowersListVC.swift
//  GithubFollowers
//
//  Created by Jagdeep Singh on 15/05/21.
//

import UIKit

class FollowersListVC: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { followers, errorMessage in
            if let followers = followers {
                print(followers.count)
                print(followers)
            }
            else {
                self.presentGFAlertOnMainThread(title: "Networ error", message: errorMessage ?? "Something went wrong", buttonTitle: "Ok")
            }
            
            
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }


}
