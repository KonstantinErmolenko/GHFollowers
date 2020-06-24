//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Ермоленко Константин on 24.06.2020.
//  Copyright © 2020 Ермоленко Константин. All rights reserved.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configue()
    }
    
    private func configue() {
        itemViewOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemViewTwo.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
}
