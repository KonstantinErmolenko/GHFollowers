//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Ермоленко Константин on 02.06.2020.
//  Copyright © 2020 Ермоленко Константин. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {

    let placeholderImage = UIImage(named: "avatar-placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configue()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configue() {
        layer.cornerRadius = 10
        clipsToBounds      = true
        image              = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
