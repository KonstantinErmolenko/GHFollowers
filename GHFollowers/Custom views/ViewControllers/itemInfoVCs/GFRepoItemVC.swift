//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Ермоленко Константин on 24.06.2020.
//  Copyright © 2020 Ермоленко Константин. All rights reserved.
//

import UIKit

protocol GFRepoItemVCDelegate: class {
    func didTapGithubProfile(for user: User)
}

class GFRepoItemVC: GFItemInfoVC {
    
    weak var delegate: GFRepoItemVCDelegate!
    
    init(user: User, delegate: GFRepoItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configue()
    }
    
    private func configue() {
        itemViewOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemViewTwo.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
     override func actionButtonTapped() {
        delegate.didTapGithubProfile(for: user)
    }
}
