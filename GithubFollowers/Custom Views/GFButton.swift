//
//  GFButton.swift
//  GithubFollowers
//
//  Created by Jagdeep Singh on 14/05/21.
//

import UIKit

class GFButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //custom code
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    init(bgColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = bgColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }

}
