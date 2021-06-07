//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Jagdeep Singh on 29/05/21.
//

import UIKit

protocol UserInfoVCDelegate: UIViewController {
    func didTapGetFollowers(for user: User)
    func didTapGithubProfile(for user: User)
}

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var itemViews:[UIView] = []
    
    var username: String!
   weak var fdelegate: FollowersListVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUserInfo()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self ,action: #selector(dismissVC) )
        navigationItem.rightBarButtonItem = doneButton
    }
    
    fileprivate func getUserInfo() {
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
                
            case .failure(let errormessage):
                self.presentGFAlertOnMainThread(title: "Error", message: errormessage.rawValue, buttonTitle: "Okay")
            }
        }
    }
    
    private func configureUIElements(with user: User) {
        
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLabel.text = "Github since \(user.createdAt.covertToDisplayFormat())"
        
    }
    
    
    func layoutUI() {
        
        itemViews = [headerView,itemViewOne,itemViewTwo,dateLabel]
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        for itemview in itemViews {
            view.addSubview(itemview)
            itemview.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
            
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


extension UserInfoVC: UserInfoVCDelegate {
    
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No followers", message: "This user has no followers", buttonTitle: "Ok")
            return
        }
        fdelegate.didResquestFollowers(for: user.login)
        dismissVC()
    }
    
    func didTapGithubProfile(for user: User) {
        print("gitHub profile")
        guard let url = URL(string: user.htmlURL) else {
            presentGFAlertOnMainThread(title: "Invaild URL", message: "The url attached to this user is invaild.", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }
    
    
}
