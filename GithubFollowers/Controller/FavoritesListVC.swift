//
//  FavoritesListVC.swift
//  GithubFollowers
//
//  Created by Jagdeep Singh on 14/05/21.
//

import UIKit

class FavoritesListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue

        PersistenceManager.retrieveFavorites { result in
            switch result {
            
            case .success(let users):
                print(users)
            case .failure(let error):
                print(error)
            }
        }
    }
    


}
