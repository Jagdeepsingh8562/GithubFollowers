//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Jagdeep Singh on 29/05/21.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self ,action: #selector(dismissVC) )
        navigationItem.rightBarButtonItem = doneButton
        layoutUI()
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                }
                print(user)
            case .failure(let errormessage):
                self.presentGFAlertOnMainThread(title: "Error", message: errormessage.rawValue, buttonTitle: "Okay")
                
            }
        }
       // print(username)
    }
    
    func layoutUI() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    func add(childVC: UIViewController, to contrainerView: UIView) {
        addChild(childVC)
        contrainerView.addSubview(childVC.view)
        childVC.view.frame = contrainerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    @objc func dismissVC(){
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }

}
