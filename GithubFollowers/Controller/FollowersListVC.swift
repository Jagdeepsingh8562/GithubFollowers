//
//  FollowersListVC.swift
//  GithubFollowers
//
//  Created by Jagdeep Singh on 15/05/21.
//

import UIKit

class FollowersListVC: UIViewController {

    var username: String!
    var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        NetworkManager.shared.getFollowers(for: username, page: 1, completion: handlerGetFollowers(result:) )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    fileprivate func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    
    private func handlerGetFollowers(result: Result<[Follower], GFError>) {
        switch result {
        case .success(let followers):
                print(followers.count)
        case .failure(let error):
            self.presentGFAlertOnMainThread(title: "Networ error", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
}
