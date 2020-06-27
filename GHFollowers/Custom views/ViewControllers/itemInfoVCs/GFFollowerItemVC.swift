//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Ермоленко Константин on 24.06.2020.
//  Copyright © 2020 Ермоленко Константин. All rights reserved.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configue()
    }
    
    private func configue() {
        itemViewOne.set(itemInfoType: .followers, with: user.followers)
        itemViewTwo.set(itemInfoType: .following, with: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }

    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
 
