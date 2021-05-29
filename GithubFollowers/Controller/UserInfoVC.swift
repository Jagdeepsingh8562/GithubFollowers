//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Jagdeep Singh on 29/05/21.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var username: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self ,action: #selector(dismissVC) )
        navigationItem.rightBarButtonItem = doneButton
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let user):
                print(user)
            case .failure(let errormessage):
                self.presentGFAlertOnMainThread(title: "Error", message: errormessage.rawValue, buttonTitle: "Okay")
                
            }
        }
       // print(username)
    }
    
    @objc func dismissVC(){
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }

}
